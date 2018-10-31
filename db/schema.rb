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

ActiveRecord::Schema.define(version: 20181031121055) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "bank_account_statements", force: :cascade do |t|
    t.string "bank_code"
    t.string "counter_number"
    t.string "account_number"
    t.string "key"
    t.string "currency"
    t.string "bank_address"
    t.string "iban"
    t.string "bic"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id"
    t.index ["user_id"], name: "index_bank_account_statements_on_user_id"
  end

  create_table "companies", force: :cascade do |t|
    t.string "title"
    t.string "address_street"
    t.string "address_postal_code"
    t.string "address_city"
    t.string "contact_first_name"
    t.string "contact_last_name"
    t.string "contact_email"
    t.string "contact_phone_number"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id"
    t.index ["user_id"], name: "index_companies_on_user_id"
  end

  create_table "email_messages", force: :cascade do |t|
    t.string "subject"
    t.text "content"
    t.bigint "invoice_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["invoice_id"], name: "index_email_messages_on_invoice_id"
  end

  create_table "expense_reports", force: :cascade do |t|
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_expense_reports_on_user_id"
  end

  create_table "expenses", force: :cascade do |t|
    t.string "description"
    t.integer "number"
    t.datetime "date"
    t.float "tva_ratio"
    t.bigint "expense_report_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "price_without_vat_cents", default: 0, null: false
    t.index ["expense_report_id"], name: "index_expenses_on_expense_report_id"
  end

  create_table "invoices", force: :cascade do |t|
    t.bigint "company_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.date "paid_at"
    t.string "title"
    t.datetime "sent_at"
    t.integer "amount_cents", default: 0, null: false
    t.integer "amount_with_vat_cents", default: 0, null: false
    t.index ["company_id"], name: "index_invoices_on_company_id"
  end

  create_table "partners", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id"
    t.index ["user_id"], name: "index_partners_on_user_id"
  end

  create_table "subcontracts", force: :cascade do |t|
    t.bigint "invoice_id"
    t.bigint "partner_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "amount_cents", default: 0, null: false
    t.index ["invoice_id"], name: "index_subcontracts_on_invoice_id"
    t.index ["partner_id"], name: "index_subcontracts_on_partner_id"
  end

  create_table "tasks", force: :cascade do |t|
    t.string "title"
    t.float "quantity"
    t.bigint "invoice_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "unit_price_cents", default: 0, null: false
    t.integer "price_without_vat_cents", default: 0, null: false
    t.integer "vat_cents", default: 0, null: false
    t.integer "price_with_vat_cents", default: 0, null: false
    t.index ["invoice_id"], name: "index_tasks_on_invoice_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "first_name"
    t.string "last_name"
    t.string "company_name"
    t.string "phone_number"
    t.string "company_street"
    t.string "company_postal_code"
    t.string "company_city"
    t.string "company_siret"
    t.string "company_rcs"
    t.boolean "admin", default: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "bank_account_statements", "users"
  add_foreign_key "companies", "users"
  add_foreign_key "email_messages", "invoices"
  add_foreign_key "expense_reports", "users"
  add_foreign_key "expenses", "expense_reports"
  add_foreign_key "invoices", "companies"
  add_foreign_key "partners", "users"
  add_foreign_key "subcontracts", "invoices"
  add_foreign_key "subcontracts", "partners"
  add_foreign_key "tasks", "invoices"
end
