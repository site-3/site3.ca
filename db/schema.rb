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

ActiveRecord::Schema.define(version: 20151115034905) do

  create_table "member_applications", force: :cascade do |t|
    t.text     "name",                                   null: false
    t.text     "email",                                  null: false
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
    t.text     "stripe_payment_token",   default: "",    null: false
    t.text     "stripe_id",              default: "",    null: false
    t.boolean  "enable_vending_machine", default: false, null: false
    t.text     "rfid"
  end

  create_table "members", force: :cascade do |t|
    t.text     "name",                                   null: false
    t.text     "email",                  default: "",    null: false
    t.text     "rfid"
    t.text     "stripe_id"
    t.text     "notes"
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
    t.string   "encrypted_password",     default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.boolean  "enable_vending_machine", default: false, null: false
    t.boolean  "doorbot_enabled",        default: false, null: false
  end

  add_index "members", ["email"], name: "index_members_on_email", unique: true
  add_index "members", ["reset_password_token"], name: "index_members_on_reset_password_token", unique: true

  create_table "oauth_identities", force: :cascade do |t|
    t.integer "member_id", null: false
    t.string  "provider",  null: false
    t.string  "uid",       null: false
  end

  add_index "oauth_identities", ["member_id", "provider"], name: "index_oauth_identities_on_member_id_and_provider", unique: true
  add_index "oauth_identities", ["provider", "uid"], name: "index_oauth_identities_on_provider_and_uid", unique: true

  create_table "versions", force: :cascade do |t|
    t.string   "item_type",  null: false
    t.integer  "item_id",    null: false
    t.string   "event",      null: false
    t.string   "whodunnit"
    t.text     "object"
    t.datetime "created_at"
  end

  add_index "versions", ["item_type", "item_id"], name: "index_versions_on_item_type_and_item_id"

end
