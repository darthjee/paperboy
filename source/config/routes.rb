# frozen_string_literal: true

Rails.application.routes.draw do
  get '/' => 'home#show', as: :home

  resources :paperboy, only: [] do
    collection do
      get '/paperboy.user' => :user_script, as: :user_script
      get '/' => :show
    end
  end

  resources :website_scripts, defaults: { format: :json }, only: [:index]

  resources :websites
  resources :scripts

  resources :users, only: [:index] do
    collection do
      resources :login, only: [:create] do
        get '/' => :check, on: :collection
      end
      delete '/logoff' => 'login#logoff'
    end
  end
end
