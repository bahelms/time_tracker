TimeTracker::Application.routes.draw do
  devise_for :users
  root to: "tasks#index"

  namespace :tasks do
    patch :manual_update
  end
  resources :tasks, only: [:create, :update, :index]

  resources :projects, only: [:index, :create, :destroy]
  resources :reports, only: [:index]
end
