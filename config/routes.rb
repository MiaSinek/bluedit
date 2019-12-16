require 'sidekiq/web'

Rails.application.routes.draw do
  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?
  mount Sidekiq::Web => '/sidekiq'

  authenticate :user, lambda { |u| u.admin? } do
    namespace :admin do
      resources :users, only: [:index]
      resources :submissions, only: [:index]
      root to: "users#index"
    end
  end

  resources :communities do
    resource :subscriptions
  end

  resources :submissions do
    resources :comments, except: [:show, :index]
  end

  get :search, controller: "application"

  post   '/votes/:type/:id', to: 'votes#create', as: :upvote
  delete '/votes/:type/:id', to: 'votes#destroy', as: :downvote

  get 'notification_subscriptions/unsubscribe/:unsubscribe_hash' => 'notification_subscriptions#unsubscribe', :as => 'unsubscribe_from_notifications'

  devise_for :users

  resources :users, only: [:show], as: "profile"

  root to: "submissions#index"
end
