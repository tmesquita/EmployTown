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

<<<<<<< HEAD
ActiveRecord::Schema.define(:version => 20111005170015) do

  create_table "roles", :force => true do |t|
    t.string   "name",                       :null => false
    t.string   "description"
    t.integer  "users_count", :default => 0
=======
ActiveRecord::Schema.define(:version => 20111005171543) do

  create_table "biddings", :force => true do |t|
    t.integer  "employer_id"
    t.integer  "seeker_id"
    t.date     "date"
    t.integer  "interested"
>>>>>>> a8fc900605aaf43830d8f36aaf955ec1a68d267c
    t.datetime "created_at"
    t.datetime "updated_at"
  end

<<<<<<< HEAD
  add_index "roles", ["name"], :name => "index_roles_on_name", :unique => true
=======
  create_table "tags", :force => true do |t|
    t.integer  "user_id"
    t.string   "tag"
    t.datetime "created_at"
    t.datetime "updated_at"
  end
>>>>>>> a8fc900605aaf43830d8f36aaf955ec1a68d267c

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
  end

  add_index "users", ["remember_me_token"], :name => "index_users_on_remember_me_token"

end
