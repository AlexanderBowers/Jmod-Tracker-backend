Rails.application.routes.draw do
  resources :usercomments
  resources :usertweets
  resources :userjmods
  resources :comments
  resources :tweets
  resources :jmods
  resources :searches
  resources :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  post '/search', to: 'searches#get_request'
  post '/reddit', to: 'searches#get_reddit'
  namespace :api do
    namespace :v1 do
      resources :users, only: [:create]
      post '/login', to: 'auth#create'
      get '/profile', to: 'users#profile'
    end
  end
end
