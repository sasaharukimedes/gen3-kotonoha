Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  root 'homes#top'
  get 'announcement', to: 'homes#announcement'

  get 'auth/:provider/callback', to: 'sessions#create'
  get 'auth/failure', to: redirect('/')
  get 'log_out', to: 'sessions#destroy', as: 'log_out'

  resources :sessions, only: %i[new create destroy]
  resources :users, only: %i[new create edit destroy]
  resource :profile


  resources :posts, shallow: true do
    resources :replies
  end

  resources :notifications, :only => [:index, :update]
  resources :contacts, only: [:new, :create]

end
