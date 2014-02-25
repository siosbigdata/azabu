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
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20140221052019) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "graphs", force: true do |t|
    t.string   "name"
    t.string   "title"
    t.integer  "analysis_type"
    t.integer  "graph_type"
    t.integer  "term"
    t.string   "y"
    t.integer  "y_min"
    t.string   "y_unit"
    t.integer  "linewidth"
    t.integer  "useval"
    t.integer  "usetip"
    t.string   "template"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "linecolor"
  end

  create_table "graphtemplates", force: true do |t|
    t.string   "linecolor"
    t.string   "bgfrom"
    t.string   "bgto"
    t.string   "textcolor"
    t.string   "name"
    t.string   "linecolor_pre"
    t.string   "linecolor_last"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "groups", force: true do |t|
    t.string   "name"
    t.string   "title"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "menus", force: true do |t|
    t.integer  "group_id"
    t.integer  "parent_id"
    t.string   "name"
    t.string   "title"
    t.integer  "vieworder"
    t.string   "icon"
    t.integer  "menutype"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "mergegraphs", force: true do |t|
    t.integer  "merge_id"
    t.integer  "graph_id"
    t.integer  "side"
    t.string   "y"
    t.integer  "vieworder"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "merges", force: true do |t|
    t.string   "name"
    t.string   "title"
    t.integer  "term"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "settings", force: true do |t|
    t.string   "name"
    t.string   "title"
    t.string   "parameter"
    t.integer  "vieworder"
    t.integer  "columntype"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "tableupdates", force: true do |t|
    t.integer  "graph_id"
    t.string   "name"
    t.integer  "term"
    t.date     "cal_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "analysis_type"
  end

  create_table "td_day_test1", id: false, force: true do |t|
    t.datetime "td_time"
    t.decimal  "td_count"
    t.integer  "analysis_type"
  end

  create_table "td_day_test2", id: false, force: true do |t|
    t.datetime "td_time"
    t.decimal  "td_count"
    t.integer  "analysis_type"
  end

  create_table "td_day_test3", id: false, force: true do |t|
    t.datetime "td_time"
    t.decimal  "td_count"
    t.integer  "analysis_type"
  end

  create_table "td_day_test4", id: false, force: true do |t|
    t.datetime "td_time"
    t.decimal  "td_count"
    t.integer  "analysis_type"
  end

  create_table "td_day_test5", id: false, force: true do |t|
    t.datetime "td_time"
    t.decimal  "td_count"
    t.integer  "analysis_type"
  end

  create_table "td_hour_test1", id: false, force: true do |t|
    t.datetime "td_time"
    t.decimal  "td_count"
    t.integer  "analysis_type"
  end

  create_table "td_hour_test2", id: false, force: true do |t|
    t.datetime "td_time"
    t.decimal  "td_count"
    t.integer  "analysis_type"
  end

  create_table "td_hour_test3", id: false, force: true do |t|
    t.datetime "td_time"
    t.decimal  "td_count"
    t.integer  "analysis_type"
  end

  create_table "td_hour_test4", id: false, force: true do |t|
    t.datetime "td_time"
    t.decimal  "td_count"
    t.integer  "analysis_type"
  end

  create_table "td_hour_test5", id: false, force: true do |t|
    t.datetime "td_time"
    t.decimal  "td_count"
    t.integer  "analysis_type"
  end

  create_table "td_month_test1", id: false, force: true do |t|
    t.datetime "td_time"
    t.decimal  "td_count"
    t.integer  "analysis_type"
  end

  create_table "td_month_test2", id: false, force: true do |t|
    t.datetime "td_time"
    t.decimal  "td_count"
    t.integer  "analysis_type"
  end

  create_table "td_month_test3", id: false, force: true do |t|
    t.datetime "td_time"
    t.decimal  "td_count"
    t.integer  "analysis_type"
  end

  create_table "td_month_test4", id: false, force: true do |t|
    t.datetime "td_time"
    t.decimal  "td_count"
    t.integer  "analysis_type"
  end

  create_table "td_month_test5", id: false, force: true do |t|
    t.datetime "td_time"
    t.decimal  "td_count"
    t.integer  "analysis_type"
  end

  create_table "td_test1", id: false, force: true do |t|
    t.datetime "td_time"
    t.decimal  "td_count"
  end

  create_table "td_test2", id: false, force: true do |t|
    t.datetime "td_time"
    t.decimal  "td_count"
  end

  create_table "td_test3", id: false, force: true do |t|
    t.datetime "td_time"
    t.decimal  "td_count"
  end

  create_table "td_test4", id: false, force: true do |t|
    t.datetime "td_time"
    t.decimal  "td_count"
  end

  create_table "td_test5", id: false, force: true do |t|
    t.datetime "td_time"
    t.decimal  "td_count"
  end

  create_table "td_week_test1", id: false, force: true do |t|
    t.datetime "td_time"
    t.decimal  "td_count"
    t.integer  "analysis_type"
  end

  create_table "td_week_test2", id: false, force: true do |t|
    t.datetime "td_time"
    t.decimal  "td_count"
    t.integer  "analysis_type"
  end

  create_table "td_week_test3", id: false, force: true do |t|
    t.datetime "td_time"
    t.decimal  "td_count"
    t.integer  "analysis_type"
  end

  create_table "td_week_test4", id: false, force: true do |t|
    t.datetime "td_time"
    t.decimal  "td_count"
    t.integer  "analysis_type"
  end

  create_table "td_week_test5", id: false, force: true do |t|
    t.datetime "td_time"
    t.decimal  "td_count"
    t.integer  "analysis_type"
  end

  create_table "users", force: true do |t|
    t.string   "name"
    t.string   "password_digest"
    t.string   "title"
    t.string   "mail"
    t.integer  "group_id"
    t.boolean  "admin"
    t.string   "auth_token"
    t.string   "password_reset_token"
    t.datetime "password_reset_sent_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
