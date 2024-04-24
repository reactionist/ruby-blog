# frozen_string_literal: true
require 'sidekiq/web'

Rails.application.routes.draw do
  mount Sidekiq::Web => '/sidekiq'

  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions'
  }

  root 'home#index'
  get '/post/:id', to: 'home#show', as: 'post'

  namespace :admin do
    root 'posts#index'
    resources :posts
    resources :tags
  end
end
