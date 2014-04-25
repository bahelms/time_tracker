TimeTracker::Application.routes.draw do
  devise_for :users
  root to: "dashboard#show"
  resources :tasks, only: [:create, :update]
  resources :projects, only: [:index, :create]
end
