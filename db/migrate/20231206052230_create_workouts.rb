class CreateWorkouts < ActiveRecord::Migration[7.0]
  def change
    create_table :workouts do |t|
      t.date :workout_date
      t.integer :duration_minutes
      t.string :equipment
      t.text :assignment
      t.string :workout_sport
      t.string :workout_intensity
      t.string :completion_status
      t.string :workout_feelings
      t.integer :user_id
      t.integer :goal_id

      t.timestamps
    end
  end
end
