class HomeController < ApplicationController
  def index
    @featured_products = Product.featured.limit(8)
  end
end
