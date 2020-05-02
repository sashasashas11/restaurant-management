# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_04_26_114034) do

  create_table "reservations", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "table_id"
    t.bigint "user_id"
    t.datetime "from"
    t.datetime "to"
    t.integer "duration"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["table_id"], name: "index_reservations_on_table_id"
    t.index ["user_id"], name: "index_reservations_on_user_id"
  end

  create_table "reserved_time_slots", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "reservation_id"
    t.bigint "table_id"
    t.bigint "user_id"
    t.datetime "time"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["reservation_id"], name: "index_reserved_time_slots_on_reservation_id"
    t.index ["table_id"], name: "index_reserved_time_slots_on_table_id"
    t.index ["user_id"], name: "index_reserved_time_slots_on_user_id"
  end

  create_table "restaurants", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name"
    t.integer "slot_step", default: 30
    t.integer "max_reserved_period", default: 24
    t.string "excluded_hours_string", default: ""
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "tables", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "number"
    t.bigint "restaurant_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["restaurant_id"], name: "index_tables_on_restaurant_id"
  end

  create_table "users", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "full_name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  add_foreign_key "reservations", "tables"
  add_foreign_key "reservations", "users"
  add_foreign_key "reserved_time_slots", "reservations"
  add_foreign_key "reserved_time_slots", "tables"
  add_foreign_key "reserved_time_slots", "users"
  add_foreign_key "tables", "restaurants"
end
