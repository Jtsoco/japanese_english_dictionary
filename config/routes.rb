Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  root to: 'words#index'
  resources :words, only: [:index]
  resources :users, only: [:show]
  namespace :user do
    resource :private_api_keys, only: :update
  end
  # resources :api, only: [:index]
  post 'api', action: :index, controller: 'api', via: [:post]

  # Defines the root path route ("/")
  # root "articles#index"
end
