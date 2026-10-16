# frozen_string_literal: true

Rails.application.routes.draw do
  namespace :admin do
    get 'login', to: 'sessions#new'
    post 'login', to: 'sessions#create'
    delete 'logout', to: 'sessions#destroy'

    root to: 'tops#index'

    resources :shops, only: [:index, :new, :create, :edit, :update]
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end