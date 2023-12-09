# == Schema Information
#
# Table name: workouts
#
#  id                :integer          not null, primary key
#  assignment        :text
#  completion_status :string
#  duration_minutes  :integer
#  equipment         :string
#  workout_date      :date
#  workout_feelings  :string
#  workout_intensity :string
#  workout_sport     :string
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  goal_id           :integer
#  user_id           :integer
#
class Workout < ApplicationRecord
  has_many  :workouts
  belongs_to :goal, foreign_key: "goal_id"
  belongs_to :user
end
