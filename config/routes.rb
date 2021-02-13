Rails.application.routes.draw do
  get 'users/show'
  devise_for :users
 root to: "homes#top"

 resources :tweets, only: [:new, :create, :index, :show, :edit, :destroy, :update] do
   resource :favorites, only: [:create, :destroy]
   resources :tweet_comments, only: [:create, :destroy]
 end
 resources :users, only: [:index, :show, :edit, :update]
 resources :relationships, only: [:create, :destroy]
end
