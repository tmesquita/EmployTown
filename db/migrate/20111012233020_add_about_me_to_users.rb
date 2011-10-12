class AddAboutMeToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :about_me, :string
  end

  def self.down
    remove_column :users, :about_me
  end
end
