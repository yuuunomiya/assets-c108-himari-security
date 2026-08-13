class CartsController < ApplicationController
  # 脆弱性を含まないバージョン（安全・参考用）：
  # 特にコードなし。ApplicationControllerがRailsの既定であるCSRFトークン検証
  # （verify_authenticity_token）を有効にしたままにしている。

  # 第7章: CSRF：
  # CSRFトークンの検証を無効化してしまうと、外部サイトに設置した
  # 自動送信フォームなどからでも、このアクションにCSRFトークンなしでPOSTできてしまう。
  #
  # skip_before_action :verify_authenticity_token, only: [:add]

  def show
    @cart = current_cart
    @cart_items = @cart.items
    @total = @cart.total
  end

  def add
    product = Product.find(params[:product_id])
    qty = params[:quantity].to_i
    qty = 1 if qty < 1

    cart[product.id.to_s] ||= 0
    cart[product.id.to_s] += qty

    redirect_to cart_path, notice: "「#{product.name}」をカートに追加しました。"
  end

  def update
    product = Product.find(params[:product_id])
    qty = params[:quantity].to_i

    if qty <= 0
      cart.delete(product.id.to_s)
    else
      cart[product.id.to_s] = qty
    end

    redirect_to cart_path, notice: "カートを更新しました。"
  end

  def remove
    product = Product.find(params[:product_id])
    cart.delete(product.id.to_s)

    redirect_to cart_path, notice: "「#{product.name}」をカートから削除しました。"
  end
end
