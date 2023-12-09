class AddUserIdToWorkouts < ActiveRecord::Migration[7.0]
  def change
    add_column :workouts, :user_id, :string
    add_column :workouts, :integer, :string
  end
end
