class DashboardController < ApplicationController
  def index
    matching_goals = Goal.where({ :user_id => current_user.id })

    @list_of_goals = matching_goals.order({ :created_at => :desc })

    matching_workouts = Workout.where({ :user_id => current_user.id })

    @list_of_workouts = matching_workouts.order({ :created_at => :desc })

    matching_workouts_today = Workout.where({ user_id: current_user.id, workout_date: Date.today })
    @list_of_workouts_today = matching_workouts_today.order({ created_at: :desc })


    #most recent goal
    @most_recent_goal = @list_of_goals.first&.goal
    @most_recent_due_date = @list_of_goals.first&.goal_due_date

    @days_till_goal = days_until_goal(@most_recent_due_date)

    @created_workouts_count = current_user.workouts_count


    render({ :template => "dashboard/index" })
  end

  def days_until_goal(goal_due_date)
    return nil unless goal_due_date

    today = Date.today
    due_date = goal_due_date.to_date

    # Calculate the difference in days
    (due_date - today).to_i
  end
end
