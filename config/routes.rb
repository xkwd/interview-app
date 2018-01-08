Rails.application.routes.draw do
  resources :interviews, only: [:index, :show, :edit, :update]
  devise_for :users
  get 'my_interviews', to: 'interviews#user_interview'
  root 'interviews#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
