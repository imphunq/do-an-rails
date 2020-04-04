class CreateAuthors < ActiveRecord::Migration[5.2]
  def change
    create_table :authors do |t|
      t.string :name
      t.date :birthday
      t.string :description
      t.string :address
      t.boolean :status, default: true

      t.timestamps
    end
  end
end
