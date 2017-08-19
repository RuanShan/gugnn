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

ActiveRecord::Schema.define(version: 20170815155652) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "average_caches", force: :cascade do |t|
    t.integer  "rater_id"
    t.string   "rateable_type"
    t.integer  "rateable_id"
    t.float    "avg",           null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "categories", force: :cascade do |t|
    t.string   "name"
    t.string   "title"
    t.integer  "parent_id"
    t.integer  "lft",                              null: false
    t.integer  "rgt",                              null: false
    t.integer  "depth",             default: 0,    null: false
    t.integer  "children_count",    default: 0,    null: false
    t.string   "slogen"
    t.string   "desc"
    t.string   "slugged"
    t.boolean  "heading",           default: true, null: false
    t.string   "icon_file_name"
    t.string   "icon_content_type"
    t.integer  "icon_file_size"
    t.datetime "icon_updated_at"
    t.string   "meta_keyword"
    t.string   "meta_description"
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
    t.index ["lft"], name: "index_categories_on_lft", using: :btree
    t.index ["parent_id"], name: "index_categories_on_parent_id", using: :btree
    t.index ["rgt"], name: "index_categories_on_rgt", using: :btree
  end

  create_table "category_options", force: :cascade do |t|
    t.integer  "category_id"
    t.integer  "position"
    t.string   "name"
    t.string   "title"
    t.string   "values"
    t.string   "filter_column_name"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.index ["category_id"], name: "index_category_options_on_category_id", using: :btree
  end

  create_table "ckeditor_assets", force: :cascade do |t|
    t.string   "data_file_name",               null: false
    t.string   "data_content_type"
    t.integer  "data_file_size"
    t.integer  "assetable_id"
    t.string   "assetable_type",    limit: 30
    t.string   "type",              limit: 30
    t.integer  "width"
    t.integer  "height"
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
    t.index ["assetable_type", "assetable_id"], name: "idx_ckeditor_assetable", using: :btree
    t.index ["assetable_type", "type", "assetable_id"], name: "idx_ckeditor_assetable_type", using: :btree
  end

  create_table "conversations", force: :cascade do |t|
    t.integer  "sender_id"
    t.integer  "recipient_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "events", force: :cascade do |t|
    t.string   "title"
    t.text     "body"
    t.string   "category"
    t.decimal  "price"
    t.string   "address"
    t.string   "date"
    t.integer  "zipcode"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "user_id"
    t.index ["user_id"], name: "index_events_on_user_id", using: :btree
  end

  create_table "images", force: :cascade do |t|
    t.string   "imageable_type"
    t.integer  "imageable_id"
    t.string   "caption"
    t.integer  "rent_id"
    t.string   "photo_file_name"
    t.string   "photo_content_type"
    t.integer  "photo_file_size"
    t.datetime "photo_updated_at"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.index ["imageable_type", "imageable_id"], name: "index_images_on_imageable_type_and_imageable_id", using: :btree
  end

  create_table "jointables", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "user_id"
    t.integer  "event_id"
    t.index ["event_id"], name: "index_jointables_on_event_id", using: :btree
    t.index ["user_id"], name: "index_jointables_on_user_id", using: :btree
  end

  create_table "messages", force: :cascade do |t|
    t.text     "body"
    t.integer  "conversation_id"
    t.integer  "user_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.index ["conversation_id"], name: "index_messages_on_conversation_id", using: :btree
    t.index ["user_id"], name: "index_messages_on_user_id", using: :btree
  end

  create_table "office_equipments", force: :cascade do |t|
    t.integer  "category_id"
    t.string   "title"
    t.string   "desc"
    t.string   "slugged"
    t.integer  "owner_id"
    t.integer  "price"
    t.integer  "f_new",        default: 0
    t.integer  "f_type",       default: 0
    t.integer  "f_brand",      default: 0
    t.integer  "f_memory",     default: 0
    t.integer  "f_hd",         default: 0
    t.integer  "f_cpu",        default: 0
    t.integer  "f_screen",     default: 0
    t.integer  "f_paper",      default: 0
    t.integer  "f_color",      default: 0
    t.integer  "f_speed",      default: 0
    t.integer  "f_sides",      default: 0
    t.integer  "f_resolution", default: 0
    t.integer  "f_luminance",  default: 0
    t.integer  "f_light",      default: 0
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.index ["category_id"], name: "index_office_equipments_on_category_id", using: :btree
  end

  create_table "option_values", force: :cascade do |t|
    t.integer  "category_option_id"
    t.integer  "position"
    t.string   "name"
    t.string   "title"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.index ["category_option_id"], name: "index_option_values_on_category_option_id", using: :btree
  end

  create_table "overall_averages", force: :cascade do |t|
    t.string   "rateable_type"
    t.integer  "rateable_id"
    t.float    "overall_avg",   null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "pets", force: :cascade do |t|
    t.integer  "category_id"
    t.string   "title"
    t.string   "desc"
    t.string   "slugged"
    t.integer  "owner_id"
    t.integer  "price"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["category_id"], name: "index_pets_on_category_id", using: :btree
  end

  create_table "pictures", force: :cascade do |t|
    t.string   "url"
    t.integer  "event_id"
    t.integer  "rent_id"
    t.integer  "sale_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["event_id"], name: "index_pictures_on_event_id", using: :btree
    t.index ["rent_id"], name: "index_pictures_on_rent_id", using: :btree
    t.index ["sale_id"], name: "index_pictures_on_sale_id", using: :btree
  end

  create_table "product_option_values", force: :cascade do |t|
    t.string   "title"
    t.integer  "category_id"
    t.string   "product_type"
    t.integer  "product_id"
    t.integer  "category_option_id"
    t.integer  "option_value_id"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.index ["category_id"], name: "index_product_option_values_on_category_id", using: :btree
    t.index ["category_option_id"], name: "index_product_option_values_on_category_option_id", using: :btree
    t.index ["option_value_id"], name: "index_product_option_values_on_option_value_id", using: :btree
    t.index ["product_type", "product_id"], name: "index_product_option_values_on_product_type_and_product_id", using: :btree
  end

  create_table "products", force: :cascade do |t|
    t.string   "type"
    t.string   "title"
    t.string   "desc"
    t.string   "slugged"
    t.integer  "owner_id"
    t.integer  "price",              default: 0,          null: false
    t.integer  "tenancy",            default: 0,          null: false
    t.integer  "min_tenancy",        default: 0,          null: false
    t.integer  "max_tenancy",        default: 0,          null: false
    t.integer  "deposit",            default: 0,          null: false
    t.integer  "category_id"
    t.string   "combofilters",       default: "00000000", null: false
    t.integer  "filt0",              default: 0,          null: false
    t.integer  "filt1",              default: 0,          null: false
    t.integer  "filt2",              default: 0,          null: false
    t.integer  "filt3",              default: 0,          null: false
    t.integer  "filt4",              default: 0,          null: false
    t.integer  "filt5",              default: 0,          null: false
    t.integer  "filt6",              default: 0,          null: false
    t.integer  "filt7",              default: 0,          null: false
    t.integer  "filt8",              default: 0,          null: false
    t.integer  "filt9",              default: 0,          null: false
    t.datetime "published_at"
    t.datetime "created_at",                              null: false
    t.datetime "updated_at",                              null: false
    t.string   "address"
    t.string   "postal_code"
    t.inet     "created_ip"
    t.decimal  "lat"
    t.decimal  "lng"
    t.point    "latlng"
    t.integer  "parent_category_id"
    t.index ["category_id"], name: "index_products_on_category_id", using: :btree
    t.index ["filt0", "filt1", "filt2", "filt3", "filt4", "filt5", "filt6", "filt7", "filt8", "filt9", "published_at"], name: "by_filter", order: { published_at: :desc }, using: :btree
    t.index ["owner_id"], name: "index_products_on_owner_id", using: :btree
    t.index ["parent_category_id", "category_id", "published_at"], name: "idx_products_pcategory_category_publish", using: :btree
    t.index ["parent_category_id"], name: "index_products_on_parent_category_id", using: :btree
  end

  create_table "rates", force: :cascade do |t|
    t.integer  "rater_id"
    t.string   "rateable_type"
    t.integer  "rateable_id"
    t.float    "stars",         null: false
    t.string   "dimension"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["rateable_id", "rateable_type"], name: "index_rates_on_rateable_id_and_rateable_type", using: :btree
    t.index ["rater_id"], name: "index_rates_on_rater_id", using: :btree
  end

  create_table "rating_caches", force: :cascade do |t|
    t.string   "cacheable_type"
    t.integer  "cacheable_id"
    t.float    "avg",            null: false
    t.integer  "qty",            null: false
    t.string   "dimension"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["cacheable_id", "cacheable_type"], name: "index_rating_caches_on_cacheable_id_and_cacheable_type", using: :btree
  end

  create_table "rents", force: :cascade do |t|
    t.string   "title"
    t.text     "body"
    t.string   "category"
    t.decimal  "price"
    t.string   "address"
    t.integer  "sqfootage"
    t.integer  "bed"
    t.integer  "bath"
    t.integer  "user_id"
    t.integer  "zipcode"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_rents_on_user_id", using: :btree
  end

  create_table "sales", force: :cascade do |t|
    t.integer  "buyer_id"
    t.string   "title"
    t.text     "body"
    t.string   "category"
    t.decimal  "price"
    t.integer  "zipcode"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_sales_on_user_id", using: :btree
  end

  create_table "users", force: :cascade do |t|
    t.string   "cellphone"
    t.string   "email",                  default: "",    null: false
    t.string   "encrypted_password",     default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.string   "nickname"
    t.string   "realname"
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.float    "rating"
    t.string   "city"
    t.integer  "balance",                default: 0
    t.integer  "role",                   default: 0
    t.boolean  "is_admin",               default: false
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
    t.index ["cellphone"], name: "index_users_on_cellphone", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  end

  add_foreign_key "events", "users"
  add_foreign_key "products", "categories", column: "parent_category_id"
  add_foreign_key "products", "users", column: "owner_id"
end
