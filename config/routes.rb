Rails.application.routes.draw do
  # devise_for :users
  root 'signup#new'
  resources :signup do
    collection do
      get 'new'
      # get 'step2'
      # get 'step3'
      # get 'step4' # ここで、入力の全てが終了する
      get 'done' # 登録完了後のページ
    end
  # resources :users, only: [:edit, :update, :show, :destroy,]
  resources :signup, only: [:index, :edit, :update, :show, :destroy,]
  resources :items, only: [:index]
  end
end