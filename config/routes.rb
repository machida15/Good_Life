Rails.application.routes.draw do
  devise_for :users
 root to: "homes#top"

 resources :tweets, only: [:new, :create, :index, :show, :destroy] do
   resources :tweet_comments, only: [:create, :destroy]
 end
end
