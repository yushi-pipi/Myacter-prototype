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
  delete '/logout', to: 'sessions#destroy'
  post '/signup', to: 'users#create'
  get '/activities/:id', to: 'microposts#start'
  patch '/microposts/:id', to: 'microposts#finish'
  resources :users
  resources :account_activations, only: [:edit]
  resources :password_resets,     only: %i[new create edit update]
  resources :activities,          only: %i[create destroy]
  resources :microposts,          only: %i[start finish edit destroy]
end
