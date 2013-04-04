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

ActiveRecord::Schema.define(:version => 20130323030455) do

  create_table "ja_blocked_phrases", :force => true do |t|
    t.text     "phrase"
    t.integer  "ja_blocked_root_id"
    t.boolean  "furigana",           :default => false
    t.datetime "created_at",                            :null => false
    t.datetime "updated_at",                            :null => false
  end

  add_index "ja_blocked_phrases", ["ja_blocked_root_id"], :name => "index_ja_blocked_phrases_on_ja_blocked_root_id"

  create_table "ja_blocked_roots", :force => true do |t|
    t.string   "root"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

end
