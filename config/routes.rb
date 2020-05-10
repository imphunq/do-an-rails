require 'sidekiq/web'
Rails.application.routes.draw do
  mount Ckeditor::Engine => '/ckeditor'
  mount Sidekiq::Web, at: '/sidekiq'
  scope "(:locale)", :locale => /en|vi/ do
    devise_for :users, controllers: {
      sessions: "users/sessions"
    }
    devise_scope :user do
      get "signin", to: "devise/sessions#new"
      post "signin" => "devise/sessions#create"
    end
    root 'static_pages#index'
    resources :books, only: :show do
      put :update_visited
    end
    resources :wishlists
    resources :carts do
      collection do
        delete "destroy_all_cart"
      end
    end
    resources :orders
    resources :categories, only: :show
    resources :notifications
    # get "/modalbook", to: "static_pages#modalbook"
    namespace :admin do
      root 'static_pages#index'
      resources :categories
      resources :roles
      resources :authors
      resources :users
      resources :books
      resources :orders
      resources :notifications, only: :update
      resources :statistic_orders, only: :index
    end
  end
  mount ActionCable.server => '/cable'
end
