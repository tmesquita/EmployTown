# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20120824034205) do

  create_table "bids", :force => true do |t|
    t.integer  "employer_id"
    t.integer  "job_seeker_id"
    t.text     "job_description"
    t.string   "job_title"
    t.string   "salary"
    t.string   "salary_term"
    t.boolean  "interested_flag"
    t.string   "contact_email"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  create_table "companies", :force => true do |t|
    t.string   "name"
    t.string   "company_url"
    t.text     "description"
    t.text     "looking_for"
    t.text     "why_work_for"
    t.string   "facebook"
    t.string   "twitter"
    t.string   "blog_address"
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
    t.string   "logo_file_name"
    t.string   "logo_content_type"
    t.integer  "logo_file_size"
    t.datetime "logo_updated_at"
  end

  create_table "roles", :force => true do |t|
    t.string   "name",        :null => false
    t.string   "description"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "roles", ["name"], :name => "index_roles_on_name", :unique => true

  create_table "tags", :force => true do |t|
    t.integer  "user_id"
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "email",                        :null => false
    t.string   "type"
    t.string   "crypted_password"
    t.string   "salt"
    t.integer  "company_id"
    t.integer  "role_id"
    t.string   "user_url"
    t.string   "first_name"
    t.string   "last_name"
    t.text     "ideal_role"
    t.text     "about_me"
    t.string   "contact_email"
    t.string   "contact_phone"
    t.string   "blog_address"
    t.string   "facebook"
    t.string   "twitter"
    t.datetime "created_at",                   :null => false
    t.datetime "updated_at",                   :null => false
    t.string   "remember_me_token"
    t.datetime "remember_me_token_expires_at"
    t.string   "photo_file_name"
    t.string   "photo_content_type"
    t.integer  "photo_file_size"
    t.datetime "photo_updated_at"
    t.string   "resume_file_name"
    t.string   "resume_content_type"
    t.integer  "resume_file_size"
    t.datetime "resume_updated_at"
  end

  add_index "users", ["remember_me_token"], :name => "index_users_on_remember_me_token"

end
