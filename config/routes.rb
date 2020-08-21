Rails.application.routes.draw do
  root "posts#index"
  resources :friendships
  resources :comments do 
    resources :likes
  end
  devise_for :users, :path => 'u', :controllers => { :omniauth_callbacks => "omniauth_callbacks", registrations: "registrations" }
  resources :users do
    resources :posts
    resources :requests
  end
  resources :posts do
    resources :likes
  end
  resources :pages
  get "users_index", to: "pages#users_index", action: :users_index
  get "profile", to: "pages#profile_info"
  get "about", to: "pages#about", action: :about
  get "/requests/friends", to: "requests#friends"
  get "/requests/accept", to: "requests#accept"
  get "/requests/deny", to: "requests#deny"
  get "/likes/comment_create", to: "likes#comment_create"
  get "/likes/comment_destroy", to: "likes#comment_destroy"
  resources :requests, only: [:new, :index, :create]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
