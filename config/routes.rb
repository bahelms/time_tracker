TimeTracker::Application.routes.draw do
  devise_for :users
  root to: "dashboard#show"
  resources :tasks
end
