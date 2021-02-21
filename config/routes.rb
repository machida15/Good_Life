Rails.application.routes.draw do
  get 'users/show'
  devise_for :users
 root to: "homes#index"
 get 'homes/about'
 post '/homes/guest_sign_in', to: 'homes#new_guest'
 get 'tweets/search'

 resources :tweets, only: [:new, :create, :index, :show, :edit, :destroy, :update] do
   resource :favorites, only: [:create, :destroy]
   resources :tweet_comments, only: [:create, :destroy]
 end
 resources :users, only: [:index, :show, :edit, :update] do
      member do
        get :following, :followers
      end
    end
 resources :relationships, only: [:create, :destroy]
 resources :notifications, only: [:index, :destroy]


end
