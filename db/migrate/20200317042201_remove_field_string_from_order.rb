class RemoveFieldStringFromOrder < ActiveRecord::Migration[5.2]
  def change
    remove_column :orders, :string, :string
  end
end
