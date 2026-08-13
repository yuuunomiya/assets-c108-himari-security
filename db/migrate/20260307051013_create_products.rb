class CreateProducts < ActiveRecord::Migration[8.1]
  def change
    create_table :products do |t|
      t.string :name, null: false
      t.text :description, null: false
      t.integer :price, null: false
      t.string :category, null: false
      t.integer :stock, null: false, default: 0
      t.string :image_url
      t.boolean :featured, null: false, default: false

      t.timestamps
    end
  end
end
