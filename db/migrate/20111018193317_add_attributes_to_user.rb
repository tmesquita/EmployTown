class AddAttributesToUser < ActiveRecord::Migration
  def self.up
    add_column :users, :ideal_role, :text
  end

  def self.down
    remove_column :users, :ideal_role
  end
end
