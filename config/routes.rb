Rails.application.routes.draw do
  devise_for :users
<<<<<<< Updated upstream
  root 'items#index'
  resources :users, only: [:edit, :update, :show, :destroy,]
=======
  resources :users, only: [:edit, :update, :show, :destroy,] do
    resources :items, only: [:new]
    # resources :mypage, only: [:index]
  end
  resources :items
  get 'users/:id/:viewname', controller: 'users', action: 'edit' #新たにコントローラを作成せずに、users_controllerのeditアクションのみで関連画面を複数表示するために、viewファイルの名前の変化のみで接続先が変わるようにしました。
  
  # 以下ガイドページ用のルート
  get 'delivery', to: 'guides#delivery'
  get 'price', to: 'guides#price'
  get 'prohibited_item', to: 'guides#prohibited_item'
  get 'prohibited_conduct', to: 'guides#prohibited_conduct'
  get 'counterfeit_goods', to: 'guides#counterfeit_goods'
  get 'seller_terms', to: 'guides#seller_terms'
>>>>>>> Stashed changes
end