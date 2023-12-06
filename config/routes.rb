Rails.application.routes.draw do
  # Routes for the Workout resource:

  # CREATE
  post("/insert_workout", { :controller => "workouts", :action => "create" })
          
  # READ
  get("/workouts", { :controller => "workouts", :action => "index" })
  
  get("/workouts/:path_id", { :controller => "workouts", :action => "show" })
  
  # UPDATE
  
  post("/modify_workout/:path_id", { :controller => "workouts", :action => "update" })
  
  # DELETE
  get("/delete_workout/:path_id", { :controller => "workouts", :action => "destroy" })

  #------------------------------

  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "workouts#index"
end
