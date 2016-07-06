class AddAdminToUsers < ActiveRecord::Migration
  def change
  	#Format: Table Name, Column Name, Type by default it will be false
  	add_column :users, :admin, :boolean, default: false
  end
end
