# frozen_string_literal: true

Rails.application.routes.draw do
  get '/' => 'home#show', as: :home

  scope controller: :paperboy, path: '/' do
    get '/paperboy.user' => :user_script, as: :user_script
    get '/paperboy' => :show, as: :paperboy_script
  end

  resources :scripts
  resources :websites do
    get '/script.user' => :user_script
  end
  resources :website_scripts, defaults: { format: :json }, only: [:index]

  resources :users, only: [:index] do
    collection do
      resources :login, only: [:create] do
        get '/' => :check, on: :collection
      end
      delete '/logoff' => 'login#logoff'
    end
  end
end
