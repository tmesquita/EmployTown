class AddSocialMediaToCompanies < ActiveRecord::Migration
  def self.up
    add_column :companies, :facebook_enabled_flag, :boolean, :default => false, :null => false
    add_column :companies, :twitter_enabled_flag, :boolean, :default => false, :null => false
    add_column :companies, :blog_enabled_flag, :boolean, :default => false, :null => false
    add_column :companies, :facebook, :string
    add_column :companies, :twitter, :string
    add_column :companies, :blog_address, :string
  end

  def self.down
    remove_column :companies, :blog_address
    remove_column :companies, :twitter
    remove_column :companies, :facebook
    remove_column :companies, :blog_enabled_flag
    remove_column :companies, :twitter_enabled_flag
    remove_column :companies, :facebook_enabled_flag
  end
end
