# frozen_string_literal: true

Rails.application.routes.draw do
  get '/' => 'home#show', as: :home
  get '/paperboy.user' => 'paperbou#user_script', as: :user_script, defaults: { format: :js }

  resources :users, only: [:index] do
    collection do
      resources :login, only: [:create] do
        get '/' => :check, on: :collection
      end
      delete '/logoff' => 'login#logoff'
    end
  end
end
