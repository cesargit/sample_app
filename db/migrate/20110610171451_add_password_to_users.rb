class AddPasswordToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :encipted_password, :string
  end

  def self.down
    remove_column :users, :encipted_password
  end
end
