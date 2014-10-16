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

ActiveRecord::Schema.define(version: 20141015214236) do

  create_table "games", force: true do |t|
    t.string   "title"
    t.string   "image"
    t.string   "quote"
    t.string   "source"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "ig_about_descriptions", force: true do |t|
    t.integer  "game_id"
    t.string   "text"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "ig_abouts", force: true do |t|
    t.integer  "ig_id"
    t.integer  "ig_about_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "ig_theme_descriptions", force: true do |t|
    t.string   "text",       limit: 1024
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "ig_themedescs", force: true do |t|
    t.integer  "theme_id"
    t.string   "ig_theme_desc"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "impact_areas", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "impact_guide_prompts", force: true do |t|
    t.integer  "impact_guide_id"
    t.string   "prompt"
    t.integer  "points"
    t.integer  "position"
    t.integer  "category_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "impact_guides", force: true do |t|
    t.integer  "creator_id"
    t.integer  "theme_id"
    t.integer  "game_id"
    t.integer  "category_id"
    t.string   "age"
    t.string   "time"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "prompt_categories", force: true do |t|
    t.string   "moniker"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "themes", force: true do |t|
    t.string   "name"
    t.integer  "ig_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "user_impact_guide_roles", force: true do |t|
    t.integer  "user_id"
    t.integer  "impact_guide_id"
    t.integer  "role"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "provider"
    t.string   "uid"
    t.string   "name"
    t.string   "oauth_token"
    t.datetime "oauth_expires_at"
    t.integer  "points"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
