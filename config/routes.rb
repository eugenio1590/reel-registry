Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "home#index"
  
  namespace :api do
    namespace :v1 do
      resources :sessions, only: [:create]
      resources :users, only: [:create]
      resources :movies
    end
  end
end
