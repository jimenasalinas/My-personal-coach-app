class WorkoutsController < ApplicationController
  def index
    matching_workouts = Workout.all

    @list_of_workouts = matching_workouts.order({ :created_at => :desc })

    render({ :template => "workouts/index" })
  end

  def show
    the_id = params.fetch("path_id")

    matching_workouts = Workout.where({ :id => the_id })

    @the_workout = matching_workouts.at(0)

    render({ :template => "workouts/show" })
  end

  def create
    the_workout = Workout.new
    the_workout.workout_date = params.fetch("query_workout_date")
    the_workout.duration_minutes = params.fetch("query_duration_minutes")
    the_workout.equipment = params.fetch("query_equipment")
    # the_workout.assignment = params.fetch("query_assignment")
    the_workout.workout_sport = params.fetch("query_workout_sport")
    the_workout.workout_intensity = params.fetch("query_workout_intensity")
    # the_workout.completion_status = params.fetch("query_completion_status")
    # the_workout.workout_feelings = params.fetch("query_workout_feelings")

    # user logged_in
    # current_user = User.find_by(id: session[:user_id])
    # goal = current_user.goals.find_or_create_by(main_goal_sport: params.fetch("query_workout_sport"))
    # the_workout.user = current_user
    # the_workout.goal = goal
    # the_workout.user_id = params.fetch("query_user_id")
    # the_workout.goal_id = params.fetch("query_goal_id")

    if the_workout.valid?
      the_workout.save
      redirect_to("/workouts", { :notice => "Workout created successfully." })
    else
      redirect_to("/workouts", { :alert => the_workout.errors.full_messages.to_sentence })
    end
  end

  def update
    the_id = params.fetch("path_id")
    the_workout = Workout.where({ :id => the_id }).at(0)

    the_workout.workout_date = params.fetch("query_workout_date")
    the_workout.duration_minutes = params.fetch("query_duration_minutes")
    the_workout.equipment = params.fetch("query_equipment")
    the_workout.assignment = params.fetch("query_assignment")
    the_workout.workout_sport = params.fetch("query_workout_sport")
    the_workout.workout_intensity = params.fetch("query_workout_intensity")
    the_workout.completion_status = params.fetch("query_completion_status")
    the_workout.workout_feelings = params.fetch("query_workout_feelings")
    # the_workout.user_id = params.fetch("query_user_id")
    # the_workout.goal_id = params.fetch("query_goal_id")

    if the_workout.valid?
      the_workout.save
      redirect_to("/workouts/#{the_workout.id}", { :notice => "Workout updated successfully."} )
    else
      redirect_to("/workouts/#{the_workout.id}", { :alert => the_workout.errors.full_messages.to_sentence })
    end
  end

  def destroy
    the_id = params.fetch("path_id")
    the_workout = Workout.where({ :id => the_id }).at(0)

    the_workout.destroy

    redirect_to("/workouts", { :notice => "Workout deleted successfully."} )
  end
end
