# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users

  resources :projects do
    resources :bugs, except: [:destroy] do
      member do
        get :assign_bug
        get :resolve_bug
      end
    end
  end

  root to: 'projects#index'
end
