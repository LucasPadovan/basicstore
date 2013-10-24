# encoding: UTF-8
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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20131022234512) do

  create_table "carts", :force => true do |t|
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "estadordens", :force => true do |t|
    t.integer  "order_id"
    t.integer  "user_id"
    t.string   "estado"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "habtm_products", :force => true do |t|
    t.integer "product_id"
    t.integer "product_type_id"
  end

  add_index "habtm_products", ["product_id", "product_type_id"], :name => "index_habtm_products_on_product_id_and_product_type_id"

  create_table "line_items", :force => true do |t|
    t.integer  "product_id"
    t.integer  "cart_id"
    t.integer  "order_id"
    t.integer  "quantity",   :default => 1
    t.datetime "created_at",                :null => false
    t.datetime "updated_at",                :null => false
  end

  create_table "mediopagos", :force => true do |t|
    t.string   "nombre"
    t.string   "descripcion"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "orders", :force => true do |t|
    t.string   "name"
    t.text     "address"
    t.string   "email"
    t.integer  "mediopago_id"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  create_table "precioproductos", :force => true do |t|
    t.integer  "product_id"
    t.decimal  "costo",         :precision => 8, :scale => 2
    t.decimal  "preciopublico", :precision => 8, :scale => 2
    t.string   "detalle"
    t.date     "validodesde"
    t.datetime "created_at",                                  :null => false
    t.datetime "updated_at",                                  :null => false
  end

  create_table "product_types", :force => true do |t|
    t.string   "name"
    t.string   "description"
    t.integer  "position"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "product_types", ["name"], :name => "index_product_types_on_name"

  create_table "products", :force => true do |t|
    t.string   "titulo"
    t.text     "descripcion"
    t.string   "image_url"
    t.decimal  "precio",          :precision => 8, :scale => 2
    t.integer  "product_type_id"
    t.integer  "cantidad"
    t.datetime "created_at",                                    :null => false
    t.datetime "updated_at",                                    :null => false
  end

  create_table "promotion_lines", :force => true do |t|
    t.string   "discount_type"
    t.float    "discount"
    t.integer  "promotion_id"
    t.integer  "product_id"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  add_index "promotion_lines", ["promotion_id", "product_id"], :name => "index_promotion_lines_on_promotion_id_and_product_id"

  create_table "promotions", :force => true do |t|
    t.string   "title"
    t.string   "color_combo"
    t.float    "total"
    t.string   "state"
    t.text     "description"
    t.datetime "start_date"
    t.datetime "end_date"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "name"
    t.string   "hashed_password"
    t.string   "salt"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

end
