# frozen_string_literal: true

Rails.application.routes.draw do
  get 'password_resets/new'

  get 'password_resets/edit'

  get 'password_reset/new'

  get 'password_reset/edit'

  get 'sessions/new'

  root 'static_pages#home'
  get '/help', to: 'static_pages#help'
  get '/about', to: 'static_pages#about'
  get '/contact', to: 'static_pages#contact'
  get '/signup', to: 'users#new'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  get 'auth/:provider/callback', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  post '/signup', to: 'users#create'
  get '/activities/:id', to: 'microposts#start'
  patch '/microposts/:id', to: 'microposts#finish'
  post '/guest', to: 'guest_sessions#create'
  resources :users do
    member do
      get :following, :followers
    end
  end
  resources :account_activations, only: [:edit]
  resources :password_resets,     only: %i[new create edit update]
  resources :activities,          only: %i[create destroy]
  resources :relationships,       only: [:create, :destroy]
  # resources :microposts,          only: %i[edit destroy]
  resources :microposts, only: %i[edit destroy] do
    collection do
      get :tweet
    end
  end
end
