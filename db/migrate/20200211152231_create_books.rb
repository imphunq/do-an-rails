class CreateBooks < ActiveRecord::Migration[5.2]
  def change
    create_table :books do |t|
      t.string :name
      t.string :publisher
      t.float :money
      t.integer :version
      t.string :description
      t.integer :quantity
      t.references :author, foreign_key: true
      t.boolean :status, default: true

      t.timestamps
    end
  end
end
