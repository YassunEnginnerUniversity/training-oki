Rails.application.routes.draw do
  root "static_pages#home"
  get "/help", to: "static_pages#help", as: "helf"
  get "/about", to: "static_pages#about"
  get "/contact", to: "static_pages#contact"
  get "/signup", to: "users#new", as: "signup"

  get "/login", to: "sessions#new"
  post "/login",   to: "sessions#create"
  delete "/logout",   to: "sessions#destory"

  resources :users
  resources :account_activations, only: [:edit]
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

end
