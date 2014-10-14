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

ActiveRecord::Schema.define(version: 20141013233129) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "integer_for_primes", force: true do |t|
    t.integer  "value"
    t.boolean  "prime"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "integer_for_primes", ["value"], name: "index_integer_for_primes_on_value", using: :btree

  create_table "workers", force: true do |t|
    t.string   "ip"
    t.datetime "last_request"
    t.integer  "requested"
    t.integer  "completed"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "workers", ["ip"], name: "index_workers_on_ip", using: :btree

end
