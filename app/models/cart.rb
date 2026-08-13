# セッションに保持したカート（{ "商品ID" => 数量 } のハッシュ）を、
# 商品オブジェクトと結びつけて扱うためのドメインオブジェクト。
#
# 以前は CartsController と OrdersController に同一の取得ロジックが重複し、
# 小計・合計の計算もビューに散らばっていた。それらをこのクラスへ集約する。
class Cart
  # カート1行（商品＋数量）。小計の計算もここに持たせる。
  CartItem = Struct.new(:product, :quantity, keyword_init: true) do
    def subtotal
      product.price * quantity
    end
  end

  def self.from_session(session_cart)
    new(session_cart || {})
  end

  def initialize(raw)
    @raw = raw
  end

  # 在庫に存在する商品だけを CartItem の配列で返す（削除済み商品は除外）。
  def items
    @items ||= begin
      products_by_id = Product.where(id: @raw.keys.map(&:to_i)).index_by { |p| p.id.to_s }

      @raw.filter_map do |product_id, quantity|
        product = products_by_id[product_id]
        next unless product

        CartItem.new(product: product, quantity: quantity.to_i)
      end
    end
  end

  def total
    items.sum(&:subtotal)
  end

  def empty?
    items.empty?
  end
end
