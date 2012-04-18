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

ActiveRecord::Schema.define(:version => 20120222002010) do

  create_table "biddings", :force => true do |t|
    t.integer  "employer_id"
    t.integer  "seeker_id"
    t.date     "date"
    t.integer  "interested"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "comment"
    t.string   "salary"
    t.string   "title"
  end

  create_table "companies", :force => true do |t|
    t.string   "name"
    t.string   "url"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "description"
  end

  create_table "roles", :force => true do |t|
    t.string   "name",                       :null => false
    t.string   "description"
    t.integer  "users_count", :default => 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "roles", ["name"], :name => "index_roles_on_name", :unique => true

  create_table "tags", :force => true do |t|
    t.integer  "user_id"
    t.string   "tag"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "email",                        :null => false
    t.string   "crypted_password"
    t.string   "salt"
    t.string   "user_url"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "seeking"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "remember_me_token"
    t.datetime "remember_me_token_expires_at"
    t.integer  "role_id"
    t.string   "photo_file_name"
    t.string   "photo_content_type"
    t.integer  "photo_file_size"
    t.datetime "photo_updated_at"
    t.string   "resume_file_name"
    t.string   "resume_content_type"
    t.integer  "resume_file_size"
    t.datetime "resume_updated_at"
    t.integer  "company_id"
    t.string   "about_me"
    t.text     "ideal_role"
  end

  add_index "users", ["remember_me_token"], :name => "index_users_on_remember_me_token"

end
