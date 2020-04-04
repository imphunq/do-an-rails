class CreateOrderDetails < ActiveRecord::Migration[5.2]
  def change
    create_table :order_details do |t|
      t.references :book, foreign_key: true
      t.references :order, foreign_key: true
      t.integer :quantity
      t.float :money

      t.timestamps
    end
  end
end
