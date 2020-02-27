Rails.application.routes.draw do
  devise_for :users
  root 'mypage#index'
  resources :users, only: [:index,:edit, :update, :show, :destroy,]
  resources :mypage,only:[:index,:edit]
  resources :logout,only:[:index,:destroy]
end