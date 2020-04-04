class CreateCategoryTypes < ActiveRecord::Migration[5.2]
  def change
    create_table :category_types do |t|
      t.references :category, foreign_key: true
      t.references :book, foreign_key: true

      t.timestamps
    end
  end
end
