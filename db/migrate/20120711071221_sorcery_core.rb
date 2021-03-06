class SorceryCore < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      t.string   :email,                 :null => false
      t.string   :type,                  :default => nil
      t.string   :crypted_password,      :default => nil
      t.string   :salt,                  :default => nil
      t.integer  :company_id,            :default => nil
      t.integer  :role_id,               :default => nil
      t.string   :user_url,              :default => nil
      t.string   :first_name,            :default => nil
      t.string   :last_name,             :default => nil
      t.text     :ideal_role,            :default => nil
      t.text     :about_me,              :default => nil
      t.string   :contact_email,         :default => nil
      t.string   :contact_phone,         :default => nil
      t.string   :blog_address,          :default => nil
      t.string   :facebook,              :default => nil
      t.string   :twitter,               :default => nil
      t.boolean  :blog_flag,             :default => false, :null => false
      t.boolean  :facebook_flag,         :default => false, :null => false
      t.boolean  :twitter_flag,          :default => false, :null => false

      t.timestamps
    end
  end

  def self.down
    drop_table :users
  end
end