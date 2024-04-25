Rails.application.routes.draw do
  devise_for :admins, skip: [:registrations]

  authenticated :admin_user do
    root to: "admin#index", as: :admin_root
  end

  get "admin" => "admin#index"
  
  # devise_for :users
  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }
  resources :user
  
  resources :courses do
    resources :lessons
  end

  namespace :admin do
    resources :courses do
      resources :lessons
    end
    resources :users
  end


  resources :checkouts, only: [:create]


  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  root "courses#index"
end
