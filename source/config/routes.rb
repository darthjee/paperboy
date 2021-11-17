# frozen_string_literal: true

Rails.application.routes.draw do
  get '/' => 'home#show', as: :home

  resources :scripts
  resources :websites do
    get '/script.user' => :user_script
  end

  scope controller: :paperboy, path: '/' do
    get '/paperboy.user' => :user_script, as: :user_script
    get '/paperboy' => :show, as: :paperboy_script
  end

  resources :website_scripts, defaults: { format: :json }, only: [:index]
  scope controller: :website_scripts, path: '/', as: :website_scripts do
    get 'website_scripts.user' => :index, as: :user_script
  end

  resources :users, only: [:index] do
    collection do
      resources :login, only: [:create] do
        get '/' => :check, on: :collection
      end
      delete '/logoff' => 'login#logoff'
    end
  end
end
