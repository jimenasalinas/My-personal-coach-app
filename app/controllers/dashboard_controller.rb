class DashboardController < ApplicationController
  def index
    matching_goals = Goal.all

    @list_of_goals = matching_goals.order({ :created_at => :desc })

    render({ :template => "dashboard/index" })
  end
end
