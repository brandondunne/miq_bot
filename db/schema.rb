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

ActiveRecord::Schema.define(version: 20140215060546) do

  create_table "commit_monitor_branches", force: true do |t|
    t.string   "name"
    t.string   "commit_uri"
    t.string   "last_commit"
    t.integer  "commit_monitor_repo_id"
    t.boolean  "pull_request"
    t.datetime "last_checked_on"
    t.datetime "last_changed_on"
    t.text     "commits_list"
    t.boolean  "mergeable"
  end

  create_table "commit_monitor_repos", force: true do |t|
    t.string   "name"
    t.string   "path"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "upstream_user"
  end

end