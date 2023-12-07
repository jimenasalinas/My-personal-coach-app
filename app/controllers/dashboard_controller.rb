class DashboardController < ApplicationController
  def index
    matching_goals = Goal.all

    @list_of_goals = matching_goals.order({ :created_at => :desc })

    #most recent goal
    @most_recent_goal = @list_of_goals.first&.goal
    @most_recent_due_date = @list_of_goals.first&.goal_due_date

    @days_till_goal = days_until_goal(@most_recent_due_date)


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
