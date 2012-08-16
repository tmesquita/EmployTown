class CreateCompanies < ActiveRecord::Migration
  def self.up
    create_table :companies do |t|
      t.string  :name
      t.string  :company_url
      t.text    :description
      t.text    :looking_for
      t.text    :why_work_for
      t.boolean :facebook_flag, :default => false, :null => false
      t.boolean :twitter_flag, :default => false, :null => false
      t.boolean :blog_flag, :default => false, :null => false
      t.string  :facebook
      t.string  :twitter
      t.string  :blog_address

      t.timestamps
    end
  end

  def self.down
    drop_table :companies
  end
end
