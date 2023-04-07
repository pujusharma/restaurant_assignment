class UpdateNameToFirstNameInUsers < ActiveRecord::Migration[7.0]
  def change
    rename_column :users, :name, :first_name
    rename_column :users, :nickname, :last_name
  end
end
