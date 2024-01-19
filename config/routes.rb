# frozen_string_literal: true

Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  root 'homes#top'
  get 'announcement', to: 'homes#announcement'
  get 'birthday-message', to: 'homes#birthday-message'
  get 'privacy-policy', to: 'homes#privacy-policy'

  get 'auth/:provider/callback', to: 'sessions#create'
  get 'auth/failure', to: redirect('/')
  get 'log_out', to: 'sessions#destroy', as: 'log_out'

  resources :sessions, only: %i[create destroy]
  resources :users, only: %i[new create edit destroy]
  resource :profile

  resources :posts, shallow: true do
    member do
      put 'archive'
    end
    resources :replies do
      member do
        put 'archive'
      end
    end
  end

  resources :notifications, only: %i[index update]
  resources :contacts, only: %i[new create]
end
