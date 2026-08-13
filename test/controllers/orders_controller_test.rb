require "test_helper"

class OrdersControllerTest < ActionDispatch::IntegrationTest
  setup { sign_in users(:regular_user) }

  test "completing an order decrements product stock" do
    product = products(:capacitor_a) # stock: 10
    post add_to_cart_path(product_id: product.id), params: { quantity: 2 }

    assert_difference -> { Order.count }, 1 do
      post orders_path
    end

    assert_equal 8, product.reload.stock
  end

  # 在庫チェックの回帰テスト（M-4）。
  test "rejects an order that exceeds available stock" do
    product = products(:low_stock) # stock: 1
    post add_to_cart_path(product_id: product.id), params: { quantity: 5 }

    assert_no_difference -> { Order.count } do
      post orders_path
    end

    assert_redirected_to cart_path
    assert_equal 1, product.reload.stock
  end
end
