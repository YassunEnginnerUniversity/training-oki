Rails.application.routes.draw do
  namespace :api, defaults: { format: :json } do
    get "check_session", to: "sessions#check"
    post "login", to: "sessions#create"
    get "users/me", to: "users#me"
    resources :users, only: [ :show ] do
      post "follow", to: "follow_users#create"
      post "unfollow", to: "follow_users#destroy"
    end
    resources :posts, only: [ :index, :show, :create ] do
      resource :like, only: [ :create ]
      resource :comments, only: [ :create ]
    end
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
end
