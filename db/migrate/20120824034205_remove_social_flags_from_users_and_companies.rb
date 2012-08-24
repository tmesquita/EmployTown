class RemoveSocialFlagsFromUsersAndCompanies < ActiveRecord::Migration
  def up
    remove_column :users, :blog_flag
    remove_column :users, :facebook_flag
    remove_column :users, :twitter_flag
    remove_column :companies, :blog_flag
    remove_column :companies, :facebook_flag
    remove_column :companies, :twitter_flag
  end

  def down
    add_column :users, :blog_flag
    add_column :users, :facebook_flag
    add_column :users, :twitter_flag
    add_column :companies, :blog_flag
    add_column :companies, :facebook_flag
    add_column :companies, :twitter_flag
  end
end
