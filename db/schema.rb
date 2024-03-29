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

ActiveRecord::Schema.define(version: 2021_03_04_012314) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "comments", force: :cascade do |t|
    t.text "body"
    t.text "permalink"
    t.bigint "jmod_id", null: false
    t.index ["jmod_id"], name: "index_comments_on_jmod_id"
  end

  create_table "jmods", force: :cascade do |t|
    t.string "name"
  end

  create_table "searches", force: :cascade do |t|
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "tweets", force: :cascade do |t|
    t.text "text"
    t.string "tweet_id"
    t.string "jmod_name"
    t.bigint "jmod_id", null: false
    t.index ["jmod_id"], name: "index_tweets_on_jmod_id"
  end

  create_table "usercomments", force: :cascade do |t|
    t.string "user_id"
    t.string "comment_id"
  end

  create_table "userjmods", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "jmod_id", null: false
    t.index ["jmod_id"], name: "index_userjmods_on_jmod_id"
    t.index ["user_id"], name: "index_userjmods_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "username"
    t.string "password_digest"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "usertweets", force: :cascade do |t|
    t.string "user_id"
    t.string "tweet_id"
  end

  add_foreign_key "comments", "jmods"
  add_foreign_key "tweets", "jmods"
  add_foreign_key "userjmods", "jmods"
  add_foreign_key "userjmods", "users"
end
