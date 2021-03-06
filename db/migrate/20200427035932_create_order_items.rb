class CreateOrderItems < ActiveRecord::Migration[6.0]
  def change
    create_table :order_items do |t|
      t.integer :quantity
      t.belongs_to :item, null: false, foreign_key: true
      t.integer :price

      t.timestamps
    end
  end
end
