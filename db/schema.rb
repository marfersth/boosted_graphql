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

ActiveRecord::Schema.define(version: 2024_02_21_202825) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "business_companies", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "groups", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "permissions", force: :cascade do |t|
    t.string "permissionable_type", null: false
    t.bigint "permissionable_id", null: false
    t.bigint "group_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["group_id"], name: "index_permissions_on_group_id"
    t.index ["permissionable_id"], name: "index_permissions_on_permissionable_id"
    t.index ["permissionable_type", "permissionable_id"], name: "index_permissions_on_permissionable"
  end

  create_table "properties", force: :cascade do |t|
    t.string "key", null: false
    t.jsonb "value", default: {}, null: false
    t.bigint "subject_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["subject_id"], name: "index_properties_on_subject_id"
  end

  create_table "subjects", force: :cascade do |t|
    t.jsonb "data", default: {}
    t.string "update_type", null: false
    t.bigint "business_company_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["business_company_id"], name: "index_subjects_on_business_company_id"
  end

  add_foreign_key "properties", "subjects"
end
