class Order < ApplicationRecord
  belongs_to :user
  has_many :order_items, dependent: :destroy
  has_many :products, through: :order_items

  enum :status, { pending: "pending", completed: "completed", cancelled: "cancelled" }

  validates :total_price, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  STATUS_LABELS = {
    "pending"   => "処理中",
    "completed" => "完了",
    "cancelled" => "キャンセル"
  }.freeze

  def status_label
    STATUS_LABELS[status] || status
  end
end
