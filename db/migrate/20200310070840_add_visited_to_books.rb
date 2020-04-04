class AddVisitedToBooks < ActiveRecord::Migration[5.2]
  def change
    add_column :books, :visited, :integer, default: 0
  end
end
