Rails.application.routes.draw do
  get 'prices/create'
  get 'stocks/create'
  get 'users/create'
  post '/users/login', to: 'users#login'
  put '/users/:id', to: 'users#update'
  delete '/users/:id', to: 'users#destroy'
  resources :users, only: [:create, :show, :destroy, :update, :login, :index]
  resources :stocks
  resources :prices
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
end
