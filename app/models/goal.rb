# == Schema Information
#
# Table name: goals
#
#  id              :integer          not null, primary key
#  goal            :text
#  goal_due_date   :date
#  goal_outcome    :string
#  goal_status     :string
#  main_goal_sport :string
#  workouts_count  :integer
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  user_id         :integer
#
class Goal < ApplicationRecord
end
