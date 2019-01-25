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

ActiveRecord::Schema.define(version: 201901041152) do

  create_table "items", id: false, force: :cascade do |t|
    t.string "uuid", default: "fa4e16e4-39b0-406a-93d4-4046e6e076b2"
    t.text "subscription"
    t.integer "journal_id"
    t.index ["journal_id"], name: "index_items_on_journal_id"
    t.index ["uuid"], name: "index_items_on_uuid"
  end

  create_table "journals", id: false, force: :cascade do |t|
    t.string "uuid", default: "aace8ebe-a743-4d94-ae74-fe209f0fca37"
    t.string "name"
    t.text "description"
  end

end
