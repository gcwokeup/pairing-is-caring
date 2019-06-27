# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users, :controllers => { :omniauth_callbacks => "omniauth_callbacks" }
  get '/appointments/:code/create', to: 'appointments#create'
  root to: 'availabilities#index'

  resources :availabilities
  resources :users
  resources :appointment_requests
end
