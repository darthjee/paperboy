# frozen_string_literal: true

Rails.application.routes.draw do
  get '/' => 'home#show', as: :home

  resource :paperboy, defaults: { format: :js }, only: [] do
    get '/paperboy.user' => :user_script
    get '/' => :show
  end

  resources :domain_scripts, only: [:index] do
    get :content, on: :member
  end

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
