Rails.application.routes.draw do
  resources :interviews, except: [:destroy] do
    resources :comments, only: [:create] do
      resources :ratings, only: [:create]
    end
    collection do
      match 'search' => 'interviews#search', via: [:get, :post], as: :search
      get 'new_form', to: 'interviews#new_form'
      post 'create_form', to: 'interviews#create_form'
    end
  end
  devise_for :users
  get 'my_interviews', to: 'interviews#user_interview'
  root 'interviews#index'
end
