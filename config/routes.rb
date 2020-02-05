Rails.application.routes.draw do
  devise_for :users
  # root ''
  resources :users, only: [:edit, :update, :show, :destroy,]
end