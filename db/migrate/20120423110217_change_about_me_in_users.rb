class ChangeAboutMeInUsers < ActiveRecord::Migration
  def self.up
    change_column :users, :about_me, :text
  end

  def self.down
    change_column :users, :about_me, :string
  end
end
