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

ActiveRecord::Schema[7.1].define(version: 2025_04_29_061428) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "commutes", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "transport_mode", null: false
    t.string "from_location", null: false
    t.string "to_location", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_commutes_on_user_id"
  end

  create_table "locations", force: :cascade do |t|
    t.string "latitude"
    t.string "longitude"
    t.float "speed"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "commute_id", null: false
    t.index ["commute_id"], name: "index_locations_on_commute_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email"
    t.string "org_slug"
    t.string "clerk_user_id"
    t.string "org_role"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
  end

  add_foreign_key "commutes", "users"
  add_foreign_key "locations", "commutes"
end
