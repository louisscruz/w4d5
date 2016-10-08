Rails.application.routes.draw do

  resources :users, only: [:show, :new, :create, :edit, :update, :destroy]
  resource :session, only: [:new, :create, :destroy]
  resources :subs
  resources :posts do
    resources :comments, only: :new
    member do
      post "downvote"
      post "upvote"
    end
  end
  resources :comments, only: [:create, :show] do
    member do
      post "downvote"
      post "upvote"
    end
  end
  root to: "subs#index"

end
