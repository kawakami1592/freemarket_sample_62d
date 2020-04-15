Rails.application.routes.draw do

  root 'items#index'
  devise_scope :user do
    get "/sign_in" => "devise/sessions#new" # login/sign_inへのカスタムパス
    get "/sign_up" => "devise/registrations#new", as: "new_user_registration" # sign_up/registrationへのカスタムパス
  end
  
  devise_for :users

  match 'items', to: 'items#update', via: [:patch, :delete]
  resources :items do
    collection do
      # カテゴリーの階層分けのルート
      get 'category_children', defaults: { format: 'json' }
      get 'category_grandchildren', defaults: { format: 'json' }
    end
    member do
      get 'buy'
      post 'pay'
    end
  end

  resources :users, only: [:edit, :update, :show, :destroy] do
    member do 
      get :logout
      get 'card',to: 'cards#show'
      get :nocard
    end
  end

  resources :cards,only: [:index]
  resources :cards, only: [:new, :show] do
    collection do
      post 'show', to: 'cards#show'
      post 'pay', to: 'cards#pay'
      post 'delete', to: 'cards#delete'
    end
  end

  # 以下ガイドページ用のルート
  resources :guides,only: [:show] do
    collection do
      get 'delivery', to: 'guides#delivery'
      get 'price', to: 'guides#price'
      get 'prohibited_item', to: 'guides#prohibited_item'
      get 'prohibited_conduct', to: 'guides#prohibited_conduct'
      get 'counterfeit_goods', to: 'guides#counterfeit_goods'
      get 'seller_terms', to: 'guides#seller_terms'
      get 'stolen_goods', to: 'guides#stolen_goods'
    end
  end    
end
