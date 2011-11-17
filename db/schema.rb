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

ActiveRecord::Schema.define(:version => 20111101123642) do

  create_table "categories", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "school_id"
    t.boolean  "system"
  end

  create_table "delayed_jobs", :force => true do |t|
    t.integer  "priority",   :default => 0
    t.integer  "attempts",   :default => 0
    t.text     "handler"
    t.text     "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "delayed_jobs", ["priority", "run_at"], :name => "delayed_jobs_priority"

  create_table "groups", :force => true do |t|
    t.string   "name",        :null => false
    t.string   "description", :null => false
    t.integer  "school_id",   :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
  end

  create_table "groups_notes", :id => false, :force => true do |t|
    t.integer "group_id", :null => false
    t.integer "note_id",  :null => false
  end

  create_table "groups_students", :id => false, :force => true do |t|
    t.integer "group_id"
    t.integer "student_id"
  end

  add_index "groups_students", ["group_id"], :name => "index_groups_students_on_group_id"
  add_index "groups_students", ["student_id", "group_id"], :name => "index_groups_students_on_student_id_and_group_id", :unique => true
  add_index "groups_students", ["student_id"], :name => "index_groups_students_on_student_id"

  create_table "guardians", :force => true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.integer  "student_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "meeting_requests", :force => true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email"
    t.text     "notes"
    t.datetime "desired_date"
    t.integer  "counselor_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "accepted"
    t.integer  "school_id"
  end

  create_table "name_prefixes", :force => true do |t|
    t.string "prefix"
  end

  create_table "notes", :force => true do |t|
    t.text     "notes"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "counselor_id"
    t.string   "summary"
    t.integer  "category_id"
    t.integer  "school_id"
    t.date     "occurred_on"
    t.string   "confidentiality_level", :default => "department"
  end

  add_index "notes", ["confidentiality_level"], :name => "notes_confidentiality_level_idx"
  add_index "notes", ["confidentiality_level"], :name => "notes_confidentiality_level_idx1"
  add_index "notes", ["occurred_on"], :name => "notes_occurred_on_idx"

  create_table "notes_smart_groups", :id => false, :force => true do |t|
    t.integer "smart_group_id"
    t.integer "note_id"
  end

  create_table "notes_students", :id => false, :force => true do |t|
    t.integer "student_id"
    t.integer "note_id"
  end

  create_table "notes_tags", :id => false, :force => true do |t|
    t.integer "note_id"
    t.integer "tag_id"
  end

  create_table "schools", :force => true do |t|
    t.string   "name"
    t.string   "address"
    t.string   "city"
    t.string   "state"
    t.string   "zip_code"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "subdomain_id"
    t.boolean  "show_tags",               :default => true
    t.boolean  "allows_meeting_requests"
  end

  add_index "schools", ["name"], :name => "index_schools_on_name", :unique => true

  create_table "smart_group_filters", :force => true do |t|
    t.string   "field_name"
    t.string   "field_value"
    t.integer  "smart_group_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "smart_groups", :force => true do |t|
    t.string   "name",       :null => false
    t.integer  "school_id",  :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
  end

  create_table "students", :force => true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "school_id"
    t.integer  "student_id"
    t.string   "primary_phone_number"
    t.string   "city"
    t.integer  "year_of_graduation"
    t.string   "shop"
    t.integer  "counselor_id"
    t.string   "full_name"
  end

  create_table "subdomains", :force => true do |t|
    t.string   "name",       :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "tags", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "school_id"
  end

  add_index "tags", ["name"], :name => "index_tags_on_name", :unique => true

  create_table "user_sessions", :force => true do |t|
    t.string   "session_id", :null => false
    t.text     "data"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "user_sessions", ["session_id"], :name => "index_counselor_sessions_on_session_id"
  add_index "user_sessions", ["updated_at"], :name => "index_counselor_sessions_on_updated_at"

  create_table "users", :force => true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "encrypted_password"
    t.string   "password_salt"
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "school_id"
    t.integer  "name_prefix_id"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "reset_password_token"
    t.string   "remember_token"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",        :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.integer  "failed_attempts",      :default => 0
    t.string   "unlock_token"
    t.datetime "locked_at"
    t.string   "role"
    t.boolean  "super_admin"
  end

  add_index "users", ["confirmation_token"], :name => "index_users_on_confirmation_token", :unique => true
  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true
  add_index "users", ["unlock_token"], :name => "index_users_on_unlock_token", :unique => true

  add_foreign_key "categories", "schools", :name => "categories_school_id_fk"

  add_foreign_key "groups_notes", "groups", :name => "groups_notes_group_id_fk"
  add_foreign_key "groups_notes", "notes", :name => "groups_notes_note_id_fk"

  add_foreign_key "groups_students", "groups", :name => "groups_students_group_id_fk"
  add_foreign_key "groups_students", "students", :name => "groups_students_student_id_fk"

  add_foreign_key "meeting_requests", "schools", :name => "meeting_requests_school_id_fk"
  add_foreign_key "meeting_requests", "users", :name => "meeting_requests_counselor_id_fk", :column => "counselor_id"

  add_foreign_key "notes", "categories", :name => "meetings_category_id_fk"
  add_foreign_key "notes", "schools", :name => "meetings_school_id_fk"
  add_foreign_key "notes", "users", :name => "meetings_counselor_id_fk", :column => "counselor_id"

  add_foreign_key "notes_smart_groups", "notes", :name => "notes_smart_groups_note_id_fk"
  add_foreign_key "notes_smart_groups", "smart_groups", :name => "notes_smart_groups_smart_group_id_fk"

  add_foreign_key "notes_students", "notes", :name => "notes_students_note_id_fk"
  add_foreign_key "notes_students", "students", :name => "notes_students_student_id_fk"

  add_foreign_key "notes_tags", "notes", :name => "meeting_tags_meeting_id_fk"
  add_foreign_key "notes_tags", "tags", :name => "meeting_tags_tag_id_fk"

  add_foreign_key "schools", "subdomains", :name => "schools_subdomain_id_fk"

  add_foreign_key "smart_groups", "schools", :name => "smart_groups_school_id_fk"

  add_foreign_key "students", "schools", :name => "students_school_id_fk"
  add_foreign_key "students", "users", :name => "students_counselor_id_fk", :column => "counselor_id"

  add_foreign_key "tags", "schools", :name => "tags_school_id_fk"

  add_foreign_key "users", "schools", :name => "users_school_id_fk"

end
