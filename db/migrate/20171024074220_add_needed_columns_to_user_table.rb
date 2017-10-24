class AddNeededColumnsToUserTable < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :first_name, :string, :default => "", :null => false
    add_column :users, :last_name, :string, :default => "", :null => false
    add_column :users, :country_code, :string, :default => "", :null => false
    add_column :users, :phone_number, :string, :default => "", :null => false
    add_column :users, :gender, :string, :default => "", :null => false
    add_column :users, :birthdate, :string, :default => "", :null => false
    add_column :users, :avatar, :string, :default => "", :null => false
  end
end
