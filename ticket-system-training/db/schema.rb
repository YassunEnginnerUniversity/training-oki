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

ActiveRecord::Schema[7.2].define(version: 2024_12_17_093308) do
  create_table "benefits", force: :cascade do |t|
    t.string "name"
    t.text "details"
    t.datetime "used_time"
    t.integer "ticket_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["ticket_id"], name: "index_benefits_on_ticket_id"
  end

  create_table "entrances", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "events", force: :cascade do |t|
    t.string "name"
    t.text "details"
    t.date "date"
    t.string "venue"
    t.time "open_time"
    t.time "start_time"
    t.time "end_time"
    t.text "notes"
    t.integer "show_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["show_id"], name: "index_events_on_show_id"
  end

  create_table "organizers", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "play_guides", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "seats", force: :cascade do |t|
    t.string "seat_area"
    t.integer "seat_number"
    t.integer "ticket_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["ticket_id"], name: "index_seats_on_ticket_id"
  end

  create_table "shows", force: :cascade do |t|
    t.string "name"
    t.datetime "start_datetime"
    t.datetime "end_datetime"
    t.text "details"
    t.integer "organizer_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["organizer_id"], name: "index_shows_on_organizer_id"
  end

  create_table "ticket_types", force: :cascade do |t|
    t.string "name"
    t.float "price"
    t.integer "event_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["event_id"], name: "index_ticket_types_on_event_id"
  end

  create_table "ticket_views", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "event_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["event_id"], name: "index_ticket_views_on_event_id"
    t.index ["user_id"], name: "index_ticket_views_on_user_id"
  end

  create_table "tickets", force: :cascade do |t|
    t.datetime "used_time"
    t.datetime "transfer_time"
    t.integer "ticket_type_id", null: false
    t.integer "entrance_id", null: false
    t.integer "ticket_view_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "play_guide_id"
    t.index ["entrance_id"], name: "index_tickets_on_entrance_id"
    t.index ["play_guide_id"], name: "index_tickets_on_play_guide_id"
    t.index ["ticket_type_id"], name: "index_tickets_on_ticket_type_id"
    t.index ["ticket_view_id"], name: "index_tickets_on_ticket_view_id"
  end

  create_table "transfers", force: :cascade do |t|
    t.integer "from_user_id"
    t.integer "to_user_id"
    t.integer "ticket_view_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["ticket_view_id"], name: "index_transfers_on_ticket_view_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "password"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
  end

  add_foreign_key "benefits", "tickets"
  add_foreign_key "events", "shows"
  add_foreign_key "seats", "tickets"
  add_foreign_key "shows", "organizers"
  add_foreign_key "ticket_types", "events"
  add_foreign_key "ticket_views", "events"
  add_foreign_key "ticket_views", "users"
  add_foreign_key "tickets", "entrances"
  add_foreign_key "tickets", "play_guides"
  add_foreign_key "tickets", "ticket_types"
  add_foreign_key "tickets", "ticket_views"
  add_foreign_key "transfers", "ticket_views"
end
