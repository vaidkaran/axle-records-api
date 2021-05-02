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

ActiveRecord::Schema.define(version: 2021_04_30_204517) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "bills", force: :cascade do |t|
    t.decimal "grand_total", precision: 7, scale: 2
    t.bigint "jobsheet_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.decimal "item_total", precision: 7, scale: 2
    t.index ["jobsheet_id"], name: "index_bills_on_jobsheet_id"
  end

  create_table "fuel_categories", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "job_profiles", force: :cascade do |t|
    t.decimal "price", precision: 7, scale: 2
    t.integer "estimatedTimeInHrs"
    t.integer "estimatedTimeInMins"
    t.bigint "shop_id"
    t.bigint "vehicle_variant_id"
    t.bigint "job_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["job_id"], name: "index_job_profiles_on_job_id"
    t.index ["shop_id"], name: "index_job_profiles_on_shop_id"
    t.index ["vehicle_variant_id"], name: "index_job_profiles_on_vehicle_variant_id"
  end

  create_table "job_trackers", force: :cascade do |t|
    t.bigint "jobsheet_id"
    t.bigint "job_profile_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["job_profile_id"], name: "index_job_trackers_on_job_profile_id"
    t.index ["jobsheet_id"], name: "index_job_trackers_on_jobsheet_id"
  end

  create_table "jobs", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "jobsheet_state_trackers", force: :cascade do |t|
    t.bigint "jobsheet_id"
    t.bigint "jobsheet_state_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["jobsheet_id"], name: "index_jobsheet_state_trackers_on_jobsheet_id"
    t.index ["jobsheet_state_id"], name: "index_jobsheet_state_trackers_on_jobsheet_state_id"
  end

  create_table "jobsheet_states", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "jobsheets", force: :cascade do |t|
    t.bigint "vehicle_id"
    t.bigint "shop_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["shop_id"], name: "index_jobsheets_on_shop_id"
    t.index ["vehicle_id"], name: "index_jobsheets_on_vehicle_id"
  end

  create_table "registration_details", force: :cascade do |t|
    t.string "reg_number"
    t.bigint "vehicle_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["vehicle_id"], name: "index_registration_details_on_vehicle_id"
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
    t.decimal "tax_percent"
    t.index ["user_id"], name: "index_shops_on_user_id"
  end

  create_table "site_roles", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "site_roles_users", id: false, force: :cascade do |t|
    t.bigint "site_role_id", null: false
    t.bigint "user_id", null: false
    t.index ["site_role_id"], name: "index_site_roles_users_on_site_role_id"
    t.index ["user_id"], name: "index_site_roles_users_on_user_id"
  end

  create_table "spare_part_profiles", force: :cascade do |t|
    t.decimal "price", precision: 7, scale: 2
    t.bigint "shop_id"
    t.bigint "vehicle_variant_id"
    t.bigint "spare_part_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["shop_id"], name: "index_spare_part_profiles_on_shop_id"
    t.index ["spare_part_id"], name: "index_spare_part_profiles_on_spare_part_id"
    t.index ["vehicle_variant_id"], name: "index_spare_part_profiles_on_vehicle_variant_id"
  end

  create_table "spare_parts", force: :cascade do |t|
    t.string "name"
    t.text "description"
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
    t.string "name"
    t.string "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "picture"
    t.string "given_name"
    t.string "family_name"
    t.string "locale"
    t.index ["email"], name: "index_users_on_email", unique: true
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
    t.bigint "fuel_category_id"
    t.bigint "transmission_category_id"
    t.index ["fuel_category_id"], name: "index_vehicle_variants_on_fuel_category_id"
    t.index ["transmission_category_id"], name: "index_vehicle_variants_on_transmission_category_id"
    t.index ["vehicle_model_id"], name: "index_vehicle_variants_on_vehicle_model_id"
  end

  create_table "vehicles", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "vehicle_brand_id"
    t.bigint "vehicle_model_id"
    t.bigint "vehicle_variant_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name"
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

  create_table "vendor_shop_roles", force: :cascade do |t|
    t.bigint "vendor_role_id"
    t.bigint "shop_id"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["shop_id"], name: "index_vendor_shop_roles_on_shop_id"
    t.index ["user_id"], name: "index_vendor_shop_roles_on_user_id"
    t.index ["vendor_role_id"], name: "index_vendor_shop_roles_on_vendor_role_id"
  end

  add_foreign_key "bills", "jobsheets"
  add_foreign_key "job_profiles", "jobs"
  add_foreign_key "job_profiles", "shops"
  add_foreign_key "job_profiles", "vehicle_variants"
  add_foreign_key "job_trackers", "job_profiles"
  add_foreign_key "job_trackers", "jobsheets"
  add_foreign_key "jobsheet_state_trackers", "jobsheet_states"
  add_foreign_key "jobsheet_state_trackers", "jobsheets"
  add_foreign_key "jobsheets", "shops"
  add_foreign_key "jobsheets", "vehicles"
  add_foreign_key "registration_details", "vehicles"
  add_foreign_key "shops", "users"
  add_foreign_key "spare_part_profiles", "shops"
  add_foreign_key "spare_part_profiles", "spare_parts"
  add_foreign_key "spare_part_profiles", "vehicle_variants"
  add_foreign_key "vehicle_models", "vehicle_brands"
  add_foreign_key "vehicle_models", "vehicle_categories"
  add_foreign_key "vehicle_variants", "fuel_categories"
  add_foreign_key "vehicle_variants", "transmission_categories"
  add_foreign_key "vehicle_variants", "vehicle_models"
  add_foreign_key "vehicles", "users"
  add_foreign_key "vehicles", "vehicle_brands"
  add_foreign_key "vehicles", "vehicle_models"
  add_foreign_key "vehicles", "vehicle_variants"
  add_foreign_key "vendor_shop_roles", "shops"
  add_foreign_key "vendor_shop_roles", "users"
  add_foreign_key "vendor_shop_roles", "vendor_roles"
end
