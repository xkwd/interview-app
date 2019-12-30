Rails.application.routes.draw do
  resources :interviews, except: [:destroy] do
    resources :comments, only: [:create] do
      resources :ratings, only: [:create]
    end
    collection do
      get :search, action: :index
      post :search, action: :index
    end
  end
  namespace :user do
    resources :interviews, only: [:index]
  end
  devise_for :users
  root 'interviews#index'
end
