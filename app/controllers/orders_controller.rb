class OrdersController < ApplicationController
  # 在庫不足で注文を確定できない場合に投げる例外（トランザクションをロールバックさせる）。
  class InsufficientStockError < StandardError; end

  before_action :authenticate_user!

  def index
    @orders = current_user.orders.order(created_at: :desc)
  end

  def show
    # 脆弱性を含まないバージョン（安全・参考用）:
    # 自分の注文だけをスコープに含めることで、他人の注文IDを指定されても
    # 見つからない扱い（404）にする。
    #
    # @order = current_user.orders.find(params[:id])

    # 第8章: IDOR:
    # current_userでスコープせずOrderを直接検索しているため、
    # 注文IDさえ分かれば他人の注文でも閲覧できてしまう。
    @order = Order.find(params[:id])
  end

  def new
    @cart = current_cart
    @cart_items = @cart.items
    @total = @cart.total

    if @cart.empty?
      redirect_to cart_path, alert: "カートが空です。"
    end
  end

  def create
    cart = current_cart

    if cart.empty?
      redirect_to cart_path, alert: "カートが空です。"
      return
    end

    ActiveRecord::Base.transaction do
      @order = current_user.orders.create!(total_price: cart.total, status: :completed)

      cart.items.each do |item|
        # 同時注文での在庫の二重引き当てを防ぐため、行ロックを取ってから検証・減算する。
        product = Product.lock.find(item.product.id)

        if product.stock < item.quantity
          raise InsufficientStockError,
                "「#{product.name}」の在庫が不足しています（在庫数: #{product.stock}）。"
        end

        product.update!(stock: product.stock - item.quantity)

        @order.order_items.create!(
          product:      product,
          product_name: product.name,
          quantity:     item.quantity,
          unit_price:   product.price
        )
      end
    end

    session.delete(:cart)
    redirect_to @order, notice: "ご注文が完了しました。ありがとうございます！"
  rescue InsufficientStockError => e
    redirect_to cart_path, alert: e.message
  rescue ActiveRecord::RecordInvalid => e
    redirect_to new_order_path, alert: "注文処理に失敗しました: #{e.message}"
  end
end
