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
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20180409161102) do

  create_table "conversations", force: :cascade do |t|
    t.integer  "sender_id"
    t.integer  "recipient_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "conversations", ["recipient_id"], name: "index_conversations_on_recipient_id"
  add_index "conversations", ["sender_id"], name: "index_conversations_on_sender_id"

  create_table "mails", force: :cascade do |t|
    t.text     "body"
    t.text     "subject"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "messages", force: :cascade do |t|
    t.text     "body"
    t.integer  "conversation_id"
    t.integer  "user_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  add_index "messages", ["conversation_id"], name: "index_messages_on_conversation_id"
  add_index "messages", ["user_id"], name: "index_messages_on_user_id"

  create_table "sprints", force: :cascade do |t|
    t.string   "title"
    t.string   "status"
    t.datetime "start_date"
    t.datetime "end_date"
    t.integer  "created_by"
  end

  create_table "tickets", force: :cascade do |t|
    t.integer "sprint_id"
    t.string  "title"
    t.integer "status"
    t.integer "created_by"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "email"
  end

  create_table "vmails", force: :cascade do |t|
    t.text     "body"
    t.text     "subject"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
