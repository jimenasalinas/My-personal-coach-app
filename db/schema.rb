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

ActiveRecord::Schema[7.0].define(version: 2023_12_06_052931) do
  create_table "goals", force: :cascade do |t|
    t.text "goal"
    t.date "goal_due_date"
    t.string "goal_status"
    t.string "main_goal_sport"
    t.string "goal_outcome"
    t.integer "user_id"
    t.integer "workouts_count"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "fitness_level"
    t.string "profile_picture"
    t.integer "goals_count"
    t.integer "workouts_count"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "workouts", force: :cascade do |t|
    t.date "workout_date"
    t.integer "duration_minutes"
    t.string "equipment"
    t.text "assignment"
    t.string "workout_sport"
    t.string "workout_intensity"
    t.string "completion_status"
    t.string "workout_feelings"
    t.integer "user_id"
    t.integer "goal_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
