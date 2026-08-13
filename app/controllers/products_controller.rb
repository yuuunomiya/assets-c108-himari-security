class ProductsController < ApplicationController
  def index
    @products = Product.available
    @products = @products.by_category(params[:category])
    @products = @products.search(params[:query])
    @products = @products.order(:name).to_a
    @categories = Product::CATEGORIES
  end

  def show
    # 脆弱性を含まないバージョン（安全・参考用）:
    # 販売停止中の商品は、存在しない商品と同じく404として扱う。
    # @product = Product.find_by!(id: params[:id], discontinued: false)

    # 第6章: SQLインジェクション:
    # 商品IDをプレースホルダを使わず直接SQL文に埋め込んでいるため、
    # discontinued の判定ごとコメントアウトで無効化されてしまう。
    @product = Product.where("id = #{params[:id]} AND discontinued = false").first!
  end
end
