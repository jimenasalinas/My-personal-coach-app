require 'openai'


class WorkoutsController < ApplicationController
  before_action :authenticate_user!

  def index
    matching_workouts = Workout.where({ :user_id => current_user.id })

    @list_of_workouts = matching_workouts.order({ :created_at => :desc })

    render({ :template => "workouts/index" })
  end

  def history
    matching_workouts = Workout.where({ :user_id => current_user.id })

    @list_of_workouts = matching_workouts.order({ :created_at => :desc })

    render({ :template => "workouts/history" })
  end

  def show
    the_id = params.fetch("path_id")

    matching_workouts = Workout.where({ :id => the_id })

    @the_workout = matching_workouts.at(0)

    render({ :template => "workouts/show" })
  end

  def create
    the_workout = Workout.new
    #add user id
    the_workout.user_id = current_user.id

    the_workout.workout_date = params.fetch("query_workout_date")
    the_workout.duration_minutes = params.fetch("query_duration_minutes")
    the_workout.equipment = params.fetch("query_equipment")
    # the_workout.assignment = params.fetch("query_assignment")
    the_workout.workout_sport = params.fetch("query_workout_sport")
    the_workout.workout_intensity = params.fetch("query_workout_intensity")
    # the_workout.completion_status = params.fetch("query_completion_status")
    # the_workout.workout_feelings = params.fetch("query_workout_feelings")
    
    # Make a join:
    the_workout.goal = goal = current_user.goals.order(created_at: :desc).first_or_create


    #for message input
    @most_recent_goal = the_workout.goal
    @most_recent_due_date = the_workout.goal.goal_due_date

    @days_till_goal = days_until_goal(@most_recent_due_date)

    if the_workout.valid?

      begin
        message = "You are my coach, I am interested in completing #{goal.main_goal_sport} workouts toward my goal of #{goal.goal} which I am targeting to meet by #{goal.goal_due_date}, which is in #{@days_till_goal}. Today I want to train #{the_workout.workout_sport}, I have #{the_workout.equipment} equipment, I am thinking of working out for about #{the_workout.duration_minutes} minutes, and today I am feeling like completing your recommended #{the_workout.workout_intensity} intensity. Please assign me a clear workout for today."

        # initialize openai client
        client = OpenAI::Client.new(access_token: ENV.fetch("MY_PERSONAI_COACH"))
        response = client.chat(
            parameters: {
                model: "gpt-3.5-turbo", # Required.
                messages: [{ role: "user", content: message}], 
                temperature: 0.7,
            })

        coach_response =  response["choices"][0]["message"]["content"]

        the_workout.assignment = coach_response 

        the_workout.save
        end
      redirect_to("/workouts", { :notice => "Workout created successfully." })
    else
      redirect_to("/workouts", { :alert => the_workout.errors.full_messages.to_sentence })
    end
  end


  def days_until_goal(goal_due_date)
    return nil unless goal_due_date

    today = Date.today
    due_date = goal_due_date.to_date

    # Calculate the difference in days
    (due_date - today).to_i
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
