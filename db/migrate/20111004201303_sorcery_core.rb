class SorceryCore < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      t.string :email,            :null => false # if you use this field as a username, you might want to make it :null => false.
      t.string :crypted_password, :default => nil
      t.string :salt,             :default => nil
      t.string :user_url,         :default => nil
      t.string :first_name,       :default => nil
      t.string :last_name,        :default => nil 
      t.integer :role_id
      t.string :photo_file_name
      t.string :photo_content_type
      t.integer :photo_file_size
      t.datetime :photo_updated_at
      t.string :resume_file_name
      t.string :resume_content_type
      t.integer :resume_file_size
      t.datetime :resume_updated_at
      t.integer :company_id
      t.string :about_me
      t.text :ideal_role

      t.timestamps
    end
  end

  def self.down
    drop_table :users
  end
end