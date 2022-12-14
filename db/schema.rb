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

ActiveRecord::Schema[7.0].define(version: 2022_10_05_160732) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "loans", force: :cascade do |t|
    t.date "start_date", null: false
    t.date "end_date", null: false
    t.decimal "amount", precision: 8, scale: 2, null: false
    t.decimal "repayment_amount", precision: 8, scale: 2, null: false
    t.integer "repayment_duration", null: false
    t.decimal "final_payment_amount", precision: 8, scale: 2, null: false
    t.string "contract_number", null: false
    t.decimal "interest", precision: 4, scale: 2, null: false
    t.decimal "interest_amount", precision: 8, scale: 2, null: false
    t.decimal "amount_with_interest", precision: 8, scale: 2, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "member_id", null: false
    t.index ["member_id"], name: "index_loans_on_member_id"
  end

  create_table "members", force: :cascade do |t|
    t.string "name", null: false
    t.string "ic_number", null: false
    t.string "number", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "loans", "members"
end
