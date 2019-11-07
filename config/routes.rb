Rails.application.routes.draw do
  resources :communities

  resources :submissions do
    resources :comments, except: [:show, :index]
  end

  devise_for :users

  resources :users, only: [:show], as: "profile"

  root to: "submissions#index"
end
