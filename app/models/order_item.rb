class OrderItem < ApplicationRecord
  belongs_to :order
  # 商品が削除された後も明細を履歴として残すため optional とする。
  belongs_to :product, optional: true

  # 商品削除後も表示できるよう、注文時点の商品名をスナップショットとして必須にする。
  validates :product_name, presence: true
  validates :quantity,   numericality: { only_integer: true, greater_than: 0 }
  validates :unit_price, numericality: { only_integer: true, greater_than: 0 }

  def subtotal
    unit_price * quantity
  end
end
