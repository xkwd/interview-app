Rails.application.routes.draw do
  resources :interviews, except: [:destroy] do
    resources :comments, only: [:create] do
      resources :ratings, only: [:create]
    end
    collection do
      match 'search' => 'interviews#search', via: [:get, :post], as: :search
    end
  end
  devise_for :users
  get 'my_interviews', to: 'interviews#user_interview'
  root 'interviews#index'
end
