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

ActiveRecord::Schema[7.0].define(version: 2026_10_13_111406) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "admins", force: :cascade do |t|
    t.string "email"
    t.string "password_digest"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_admins_on_email", unique: true
  end

  create_table "areas", force: :cascade do |t|
    t.string "name", null: false, comment: "エリア名"
    t.integer "sort_order", default: 0, null: false, comment: "表示順"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_areas_on_name", unique: true
  end

  create_table "machines", force: :cascade do |t|
    t.bigint "shop_id", null: false, comment: "店舗ID"
    t.string "name", null: false, comment: "機器名"
    t.integer "quantity", default: 1, null: false, comment: "台数"
    t.string "capacity", comment: "容量"
    t.string "price", comment: "料金"
    t.text "description", comment: "補足説明"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["shop_id"], name: "index_machines_on_shop_id"
  end

  create_table "shop_requests", force: :cascade do |t|
    t.bigint "admin_id", comment: "対応管理者ID (NULL許可)"
    t.integer "request_type", default: 0, null: false, comment: "種別(0:新規掲載, 1:情報修正, 2:閉業報告)"
    t.string "shop_name", null: false, comment: "対象店舗名"
    t.string "address", comment: "住所(任意)"
    t.text "body", null: false, comment: "リクエスト詳細"
    t.integer "status", default: 0, null: false, comment: "ステータス(0:未対応, 1:完了, 2:不採用)"
    t.text "admin_note", comment: "管理者用メモ"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["admin_id"], name: "index_shop_requests_on_admin_id"
  end

  create_table "shops", force: :cascade do |t|
    t.bigint "area_id", null: false, comment: "エリアID"
    t.string "name", null: false, comment: "店舗名"
    t.string "address", null: false, comment: "住所"
    t.float "latitude", comment: "緯度(geocoder)"
    t.float "longitude", comment: "経度(geocoder)"
    t.string "opening_hours", comment: "営業時間"
    t.boolean "parking_available", default: false, null: false, comment: "駐車場有無"
    t.string "google_maps_url", comment: "GoogleマップURL"
    t.string "website_url", comment: "公式URL"
    t.boolean "published", default: false, null: false, comment: "掲載フラグ"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["area_id"], name: "index_shops_on_area_id"
  end

  add_foreign_key "machines", "shops"
  add_foreign_key "shop_requests", "admins"
  add_foreign_key "shops", "areas"
end
