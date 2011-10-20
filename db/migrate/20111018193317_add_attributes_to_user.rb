class AddAttributesToUser < ActiveRecord::Migration
  def self.up
    add_column :users, :experience, :text
  end

  def self.down
    drop_column :users, :experience
  end
end
