class AddContactInfoToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :contact_email, :string
    add_column :users, :contact_phone, :string
    add_column :users, :blog_address, :string
    add_column :users, :facebook, :string
    add_column :users, :twitter, :string
    add_column :users, :blog_enabled_flag, :boolean, :default => false, :null => false
    add_column :users, :facebook_enabled_flag, :boolean, :default => false, :null => false
    add_column :users, :twitter_enabled_flag, :boolean, :default => false, :null => false
  end

  def self.down
    remove_column :users, :twitter_enabled_flag
    remove_column :users, :facebook_enabled_flag
    remove_column :users, :blog_enabled_flag
    remove_column :users, :twitter
    remove_column :users, :facebook
    remove_column :users, :blog_address
    remove_column :users, :contact_phone
    remove_column :users, :contact_email
  end
end
