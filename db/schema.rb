# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2023_02_19_213214) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "batches", force: :cascade do |t|
    t.integer "serialnumber", null: false
    t.string "description"
    t.integer "liters"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["serialnumber"], name: "index_batches_on_serialnumber", unique: true
  end

  create_table "labels", force: :cascade do |t|
    t.bigint "batch_id", null: false
    t.string "code", null: false
    t.string "description"
    t.integer "number_of_labels", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["batch_id"], name: "index_labels_on_batch_id"
    t.index ["code"], name: "index_labels_on_code", unique: true
  end

  create_table "qrcodes", force: :cascade do |t|
    t.integer "referencenumber", null: false
    t.string "baseurl", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["referencenumber"], name: "index_qrcodes_on_referencenumber", unique: true
  end

  create_table "qrlinks", force: :cascade do |t|
    t.bigint "label_id", null: false
    t.bigint "qrcode_id", null: false
    t.string "url", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["label_id"], name: "index_qrlinks_on_label_id"
    t.index ["qrcode_id"], name: "index_qrlinks_on_qrcode_id"
  end

  create_table "qrtags", force: :cascade do |t|
    t.bigint "qrcode_id", null: false
    t.bigint "label_id", null: false
    t.bigint "qrlink_id"
    t.datetime "claimed_on"
    t.string "code", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "labelnumber", null: false
    t.index ["label_id", "code"], name: "index_qrtags_on_label_id_and_code", unique: true
    t.index ["label_id"], name: "index_qrtags_on_label_id"
    t.index ["qrcode_id"], name: "index_qrtags_on_qrcode_id"
    t.index ["qrlink_id"], name: "index_qrtags_on_qrlink_id"
  end

  add_foreign_key "labels", "batches"
  add_foreign_key "qrlinks", "labels"
  add_foreign_key "qrlinks", "qrcodes"
  add_foreign_key "qrtags", "labels"
  add_foreign_key "qrtags", "qrcodes"
  add_foreign_key "qrtags", "qrlinks"
end
