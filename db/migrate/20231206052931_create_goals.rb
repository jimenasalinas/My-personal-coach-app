class CreateGoals < ActiveRecord::Migration[7.0]
  def change
    create_table :goals do |t|
      t.text :goal
      t.date :goal_due_date
      t.string :goal_status
      t.string :main_goal_sport
      t.string :goal_outcome
      t.integer :user_id
      t.integer :workouts_count

      t.timestamps
    end
  end
end
