Rails.application.routes.draw do
  devise_for :users
  root 'items#new'
  resources :users, only: [:edit, :update, :show, :destroy,] do
    resources :items
  end


  # 以下ガイドページ用のルート
  get 'delivery', to: 'guides#delivery'
  get 'price', to: 'guides#price'
  get 'prohibited_item', to: 'guides#prohibited_item'
  get 'prohibited_conduct', to: 'guides#prohibited_conduct'
  get 'counterfeit_goods', to: 'guides#counterfeit_goods'
  get 'seller_terms', to: 'guides#seller_terms'
end
