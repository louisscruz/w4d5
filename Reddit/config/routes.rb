Rails.application.routes.draw do

  resources :users, only: [:show, :new, :create, :edit, :update, :destroy]
  resource :session, only: [:new, :create, :destroy]
  resources :subs
  resources :posts
  root to: "subs#index"

end
