Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get 'up' => 'rails/health#show', as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"

  # this is for documentation of api with Oasrails
  mount OasRails::Engine => '/docs'

  # resources :event do
  #   resources :attendees, [:summary] # /events/:event_id/attendees, # /events/:event_id/attendees/summary
  # end

  # resources :attendees do
  #   resources :confirm # /attendees/:attendee_id/confirm
  # end
end
