TimeTracker::Application.routes.draw do
  devise_for :users
  root to: "tasks#index"
  resources :tasks, only: [:create, :update, :index]
  resources :projects, only: [:index, :create, :destroy]
  resources :reports, only: [:index]
end
