Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: "users/registrations" }

  # 第7章: CSRF演習用。本来は破壊的操作にGETを使うべきではないが、
  # 「ワンクリックで退会できる」利便性のために誤ってGETで実装してしまうと、
  # 外部サイトからのCSRF攻撃で退会させられてしまう（vuln/ch07-csrfブランチで有効化）。
  #
  # devise_scope :user do
  #   get "users/quick_delete", to: "users/registrations#quick_delete", as: :quick_delete_registration
  # end

  get "up" => "rails/health#show", as: :rails_health_check

  root "home#index"

  resources :products, only: [ :index, :show ]

  resource :cart, only: [ :show ] do
    post   "add/:product_id",    to: "carts#add",    as: :add_to
    patch  "update/:product_id", to: "carts#update", as: :update_item
    delete "remove/:product_id", to: "carts#remove", as: :remove_from
  end

  resources :orders, only: [ :index, :show, :new, :create ]

  resource :profile, only: [ :show, :edit, :update ]

  namespace :admin do
    resources :products
  end
end
