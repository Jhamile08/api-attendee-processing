Rails.application.routes.draw do
  get 'user_attendees/index'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get 'up' => 'rails/health#show', as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"

  # this is for documentation of api with Oasrails
  mount OasRails::Engine => '/docs'

  # POST /events/:event_id/attendees
  get '/events/:event_id/attendees' => 'attendees#create_attendees'

  #  PATCH /attendees/:attendee_id/confirm, /attendees/:attendee_id/cancel, GET /attendees/:attendee_id/logs`

  resources :attendees do
    member do
      patch :confirm
      patch :cancel
      get :logs
    end
  end

  get 'user_attendees/show_user_attendees', to: 'user_attendees#show_user_attendees'

  #  GET /events/:event_id/attendees/summary
  #  get '/events/:event_id/attendees/summary' => 'attendees#summary', as: :rails_health_check
  #

  # GET /attendees/:attendee_id/logs
  # get 'attendees/:attendee_id/logs', to: 'attendees#logs', as: 'attendee_logs'
  # resources :attendees do
  #   member do
  #     get :"logs"
  #   end
  # end
end
