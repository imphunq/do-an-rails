class AddStaffTypeToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :staff_type, :integer
  end
end
