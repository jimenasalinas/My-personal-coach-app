class GoalsController < ApplicationController
  def index
    matching_goals = Goal.all

    @list_of_goals = matching_goals.order({ :created_at => :desc })

    #most recent goal
    @most_recent_goal = @list_of_goals.first&.goal

    render({ :template => "goals/index" })
  end

  def show
    the_id = params.fetch("path_id")

    matching_goals = Goal.where({ :id => the_id })

    @the_goal = matching_goals.at(0)

    render({ :template => "goals/show" })
  end

  def create
    # current_user = User.find_by(id: session[:user_id])

    the_goal = Goal.new
    the_goal = Goal.new
    the_goal.goal = params.fetch("query_goal")
    the_goal.goal_due_date = params.fetch("query_goal_due_date")
    # the_goal.goal_status = params.fetch("query_goal_status")
    the_goal.main_goal_sport = params.fetch("query_main_goal_sport")
    # the_goal.goal_outcome = params.fetch("query_goal_outcome")
    # the_goal.user_id = params.fetch("query_user_id")
    # the_goal.workouts_count = params.fetch("query_workouts_count")

    # the_goal.user = current_user

    if the_goal.valid?
      the_goal.save
      redirect_to("/goals", { :notice => "Goal created successfully." })
    else
      redirect_to("/goals", { :alert => the_goal.errors.full_messages.to_sentence })
    end
  end

  def update
    the_id = params.fetch("path_id")
    the_goal = Goal.where({ :id => the_id }).at(0)

    the_goal.goal = params.fetch("query_goal")
    the_goal.goal_due_date = params.fetch("query_goal_due_date")
    the_goal.goal_status = params.fetch("query_goal_status")
    the_goal.main_goal_sport = params.fetch("query_main_goal_sport")
    the_goal.goal_outcome = params.fetch("query_goal_outcome")
    the_goal.user_id = params.fetch("query_user_id")
    the_goal.workouts_count = params.fetch("query_workouts_count")

    if the_goal.valid?
      the_goal.save
      redirect_to("/goals/#{the_goal.id}", { :notice => "Goal updated successfully."} )
    else
      redirect_to("/goals/#{the_goal.id}", { :alert => the_goal.errors.full_messages.to_sentence })
    end
  end

  def destroy
    the_id = params.fetch("path_id")
    the_goal = Goal.where({ :id => the_id }).at(0)

    the_goal.destroy

    redirect_to("/goals", { :notice => "Goal deleted successfully."} )
  end
end
