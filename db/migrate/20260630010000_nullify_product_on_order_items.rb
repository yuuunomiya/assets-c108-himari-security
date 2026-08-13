class NullifyProductOnOrderItems < ActiveRecord::Migration[8.1]
  # 商品が削除されても注文明細（注文履歴）を残すため、
  # order_items.product_id を NULL 許可にし、外部キーを ON DELETE SET NULL に変更する。
  # 明細は product_name / unit_price のスナップショットを保持しているため履歴は失われない。
  def up
    change_column_null :order_items, :product_id, true
    remove_foreign_key :order_items, :products
    add_foreign_key :order_items, :products, on_delete: :nullify
  end

  def down
    remove_foreign_key :order_items, :products
    add_foreign_key :order_items, :products
    change_column_null :order_items, :product_id, false
  end
end
