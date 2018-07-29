Rails.application.routes.draw do
  resources :interviews, except: [:destroy] do
    resources :comments
    collection do
      match 'search' => 'interviews#search', via: [:get, :post], as: :search
    end
  end
  devise_for :users
  get 'my_interviews', to: 'interviews#user_interview'
  get 'recently_published', to: 'interviews#recently_published'
  root 'interviews#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
