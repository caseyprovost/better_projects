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

ActiveRecord::Schema.define(version: 2020_04_10_153356) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "account_members", force: :cascade do |t|
    t.bigint "account_id", null: false
    t.bigint "user_id", null: false
    t.bigint "role_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["account_id"], name: "index_account_members_on_account_id"
    t.index ["role_id"], name: "index_account_members_on_role_id"
    t.index ["user_id", "account_id"], name: "index_account_members_on_user_id_and_account_id", unique: true
    t.index ["user_id"], name: "index_account_members_on_user_id"
  end

  create_table "account_roles", force: :cascade do |t|
    t.string "name", null: false
    t.string "slug", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["name"], name: "index_account_roles_on_name", unique: true
    t.index ["slug"], name: "index_account_roles_on_slug", unique: true
  end

  create_table "accounts", force: :cascade do |t|
    t.string "name", null: false
    t.string "subdomain", null: false
    t.boolean "active", default: true, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["name"], name: "index_accounts_on_name", unique: true
    t.index ["subdomain"], name: "index_accounts_on_subdomain", unique: true
  end

  create_table "action_text_rich_texts", force: :cascade do |t|
    t.string "name", null: false
    t.text "body"
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["record_type", "record_id", "name"], name: "index_action_text_rich_texts_uniqueness", unique: true
  end

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "assignments", force: :cascade do |t|
    t.string "assignable_type", null: false
    t.bigint "assignable_id", null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["assignable_type", "assignable_id"], name: "index_assignments_on_assignable_type_and_assignable_id"
    t.index ["user_id"], name: "index_assignments_on_user_id"
  end

  create_table "buckets", force: :cascade do |t|
    t.string "bucketable_type", null: false
    t.bigint "bucketable_id", null: false
    t.bigint "account_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["account_id"], name: "index_buckets_on_account_id"
    t.index ["bucketable_type", "bucketable_id"], name: "index_buckets_on_bucketable_type_and_bucketable_id"
  end

  create_table "comments", force: :cascade do |t|
    t.string "commentable_type", null: false
    t.bigint "commentable_id", null: false
    t.bigint "creator_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["commentable_type", "commentable_id"], name: "index_comments_on_commentable_type_and_commentable_id"
    t.index ["creator_id"], name: "index_comments_on_creator_id"
  end

  create_table "events", force: :cascade do |t|
    t.bigint "recording_id", null: false
    t.bigint "creator_id"
    t.string "action", null: false
    t.json "details", default: "{}", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["action"], name: "index_events_on_action"
    t.index ["creator_id"], name: "index_events_on_creator_id"
    t.index ["recording_id"], name: "index_events_on_recording_id"
  end

  create_table "message_boards", force: :cascade do |t|
    t.bigint "project_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["project_id"], name: "index_message_boards_on_project_id", unique: true
  end

  create_table "messages", force: :cascade do |t|
    t.bigint "message_board_id", null: false
    t.bigint "creator_id", null: false
    t.text "subject", default: "", null: false
    t.text "content", default: "", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["creator_id"], name: "index_messages_on_creator_id"
    t.index ["message_board_id"], name: "index_messages_on_message_board_id"
  end

  create_table "project_memberships", force: :cascade do |t|
    t.bigint "project_id", null: false
    t.bigint "user_id", null: false
    t.string "status", default: "active", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["project_id", "user_id"], name: "index_project_memberships_on_project_id_and_user_id", unique: true
    t.index ["project_id"], name: "index_project_memberships_on_project_id"
    t.index ["user_id"], name: "index_project_memberships_on_user_id"
  end

  create_table "projects", force: :cascade do |t|
    t.bigint "account_id", null: false
    t.string "name", null: false
    t.string "status", default: "active", null: false
    t.text "description", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["account_id"], name: "index_projects_on_account_id"
  end

  create_table "recordings", force: :cascade do |t|
    t.string "recordable_type", null: false
    t.bigint "recordable_id", null: false
    t.bigint "bucket_id", null: false
    t.string "parent_type", null: false
    t.bigint "parent_id", null: false
    t.string "status", default: "active", null: false
    t.string "title", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "trashed_by_id"
    t.datetime "trashed_at"
    t.bigint "archived_by_id"
    t.datetime "archived_at"
    t.index ["archived_by_id"], name: "index_recordings_on_archived_by_id"
    t.index ["bucket_id"], name: "index_recordings_on_bucket_id"
    t.index ["parent_type", "parent_id"], name: "index_recordings_on_parent_type_and_parent_id"
    t.index ["recordable_type", "recordable_id"], name: "index_recordings_on_recordable_type_and_recordable_id"
    t.index ["trashed_by_id"], name: "index_recordings_on_trashed_by_id"
  end

  create_table "subscribers", force: :cascade do |t|
    t.bigint "subscription_id", null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["subscription_id", "user_id"], name: "index_subscribers_on_subscription_id_and_user_id", unique: true
    t.index ["subscription_id"], name: "index_subscribers_on_subscription_id"
    t.index ["user_id"], name: "index_subscribers_on_user_id"
  end

  create_table "subscriptions", force: :cascade do |t|
    t.bigint "recording_id", null: false
    t.string "action", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["action"], name: "index_subscriptions_on_action"
    t.index ["recording_id"], name: "index_subscriptions_on_recording_id"
  end

  create_table "todo_lists", force: :cascade do |t|
    t.bigint "todo_set_id", null: false
    t.bigint "creator_id", null: false
    t.string "title", null: false
    t.integer "todos_count", default: 0, null: false
    t.integer "position", default: 0, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["creator_id"], name: "index_todo_lists_on_creator_id"
    t.index ["position", "todo_set_id"], name: "index_todo_lists_on_position_and_todo_set_id", unique: true
    t.index ["todo_set_id"], name: "index_todo_lists_on_todo_set_id"
  end

  create_table "todo_sets", force: :cascade do |t|
    t.bigint "bucket_id", null: false
    t.bigint "creator_id", null: false
    t.string "title", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "todo_lists_count", default: 0, null: false
    t.index ["bucket_id"], name: "index_todo_sets_on_bucket_id"
    t.index ["creator_id"], name: "index_todo_sets_on_creator_id"
  end

  create_table "todos", force: :cascade do |t|
    t.bigint "todo_list_id", null: false
    t.bigint "creator_id", null: false
    t.string "title", null: false
    t.integer "position", default: 0, null: false
    t.boolean "completed", default: false, null: false
    t.datetime "starts_on"
    t.datetime "due_on"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["creator_id"], name: "index_todos_on_creator_id"
    t.index ["due_on"], name: "index_todos_on_due_on"
    t.index ["position", "todo_list_id"], name: "index_todos_on_position_and_todo_list_id", unique: true
    t.index ["starts_on"], name: "index_todos_on_starts_on"
    t.index ["todo_list_id"], name: "index_todos_on_todo_list_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "name", default: "", null: false
    t.string "phone_number"
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.integer "failed_attempts", default: 0, null: false
    t.string "unlock_token"
    t.datetime "locked_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["unlock_token"], name: "index_users_on_unlock_token", unique: true
  end

  create_table "versions", force: :cascade do |t|
    t.string "item_type", null: false
    t.bigint "item_id", null: false
    t.string "event", null: false
    t.string "whodunnit"
    t.text "object"
    t.datetime "created_at"
    t.text "object_changes"
    t.index ["item_type", "item_id"], name: "index_versions_on_item_type_and_item_id"
  end

  add_foreign_key "account_members", "account_roles", column: "role_id"
  add_foreign_key "account_members", "accounts"
  add_foreign_key "account_members", "users"
  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "assignments", "users"
  add_foreign_key "buckets", "accounts"
  add_foreign_key "comments", "users", column: "creator_id"
  add_foreign_key "events", "recordings"
  add_foreign_key "events", "users", column: "creator_id"
  add_foreign_key "message_boards", "projects"
  add_foreign_key "messages", "message_boards"
  add_foreign_key "messages", "users", column: "creator_id"
  add_foreign_key "project_memberships", "projects"
  add_foreign_key "project_memberships", "users"
  add_foreign_key "projects", "accounts"
  add_foreign_key "recordings", "buckets"
  add_foreign_key "recordings", "users", column: "archived_by_id"
  add_foreign_key "recordings", "users", column: "trashed_by_id"
  add_foreign_key "subscribers", "subscriptions"
  add_foreign_key "subscribers", "users"
  add_foreign_key "subscriptions", "recordings"
  add_foreign_key "todo_lists", "todo_sets"
  add_foreign_key "todo_lists", "users", column: "creator_id"
  add_foreign_key "todo_sets", "buckets"
  add_foreign_key "todo_sets", "users", column: "creator_id"
  add_foreign_key "todos", "todo_lists"
  add_foreign_key "todos", "users", column: "creator_id"
end
