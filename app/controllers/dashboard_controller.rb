class DashboardController < ApplicationController
  def index
    matching_goals = Goal.all

    @list_of_goals = matching_goals.order({ :created_at => :desc })

    #most recent goal
    @most_recent_goal = @list_of_goals.first.goal

    render({ :template => "dashboard/index" })
  end

end
