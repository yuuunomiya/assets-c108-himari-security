require "test_helper"

class CartTest < ActiveSupport::TestCase
  test "maps session quantities to products and computes subtotal" do
    product = products(:capacitor_a)
    cart = Cart.from_session({ product.id.to_s => 3 })

    assert_equal 1, cart.items.size
    item = cart.items.first
    assert_equal product, item.product
    assert_equal 3, item.quantity
    assert_equal product.price * 3, item.subtotal
  end

  test "total sums the subtotals of all items" do
    a = products(:capacitor_a)
    b = products(:resistor_a)
    cart = Cart.from_session({ a.id.to_s => 2, b.id.to_s => 1 })

    assert_equal((a.price * 2) + (b.price * 1), cart.total)
  end

  test "ignores products that no longer exist" do
    cart = Cart.from_session({ "999999" => 1 })

    assert cart.empty?
    assert_equal 0, cart.total
  end
end
