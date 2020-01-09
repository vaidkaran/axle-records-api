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

ActiveRecord::Schema.define(version: 2020_01_09_200754) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "fuel_categories", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "registration_details", force: :cascade do |t|
    t.string "reg_number"
    t.bigint "vehicle_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["vehicle_id"], name: "index_registration_details_on_vehicle_id"
  end

  create_table "shop_users", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "shop_id"
    t.bigint "vendor_role_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["shop_id"], name: "index_shop_users_on_shop_id"
    t.index ["user_id"], name: "index_shop_users_on_user_id"
    t.index ["vendor_role_id"], name: "index_shop_users_on_vendor_role_id"
  end

  create_table "shops", force: :cascade do |t|
    t.string "name"
    t.string "address"
    t.string "city"
    t.string "state"
    t.integer "pin"
    t.string "country"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_shops_on_user_id"
  end

  create_table "site_roles", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "transmission_categories", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "provider", default: "email", null: false
    t.string "uid", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.boolean "allow_password_change", default: false
    t.datetime "remember_created_at"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.string "name"
    t.string "nickname"
    t.string "image"
    t.string "email"
    t.json "tokens"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.bigint "site_role_id"
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["site_role_id"], name: "index_users_on_site_role_id"
    t.index ["uid", "provider"], name: "index_users_on_uid_and_provider", unique: true
  end

  create_table "vehicle_brands", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "vehicle_categories", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "vehicle_models", force: :cascade do |t|
    t.string "name"
    t.bigint "vehicle_brand_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "vehicle_category_id"
    t.index ["vehicle_brand_id"], name: "index_vehicle_models_on_vehicle_brand_id"
    t.index ["vehicle_category_id"], name: "index_vehicle_models_on_vehicle_category_id"
  end

  create_table "vehicle_variants", force: :cascade do |t|
    t.string "name"
    t.bigint "vehicle_model_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["vehicle_model_id"], name: "index_vehicle_variants_on_vehicle_model_id"
  end

  create_table "vehicles", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "fuel_category_id"
    t.bigint "transmission_category_id"
    t.bigint "vehicle_brand_id"
    t.bigint "vehicle_model_id"
    t.bigint "vehicle_variant_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name"
    t.index ["fuel_category_id"], name: "index_vehicles_on_fuel_category_id"
    t.index ["transmission_category_id"], name: "index_vehicles_on_transmission_category_id"
    t.index ["user_id"], name: "index_vehicles_on_user_id"
    t.index ["vehicle_brand_id"], name: "index_vehicles_on_vehicle_brand_id"
    t.index ["vehicle_model_id"], name: "index_vehicles_on_vehicle_model_id"
    t.index ["vehicle_variant_id"], name: "index_vehicles_on_vehicle_variant_id"
  end

  create_table "vendor_roles", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "registration_details", "vehicles"
  add_foreign_key "shop_users", "shops"
  add_foreign_key "shop_users", "users"
  add_foreign_key "shop_users", "vendor_roles"
  add_foreign_key "shops", "users"
  add_foreign_key "users", "site_roles"
  add_foreign_key "vehicle_models", "vehicle_brands"
  add_foreign_key "vehicle_models", "vehicle_categories"
  add_foreign_key "vehicle_variants", "vehicle_models"
  add_foreign_key "vehicles", "fuel_categories"
  add_foreign_key "vehicles", "transmission_categories"
  add_foreign_key "vehicles", "users"
  add_foreign_key "vehicles", "vehicle_brands"
  add_foreign_key "vehicles", "vehicle_models"
  add_foreign_key "vehicles", "vehicle_variants"
end
