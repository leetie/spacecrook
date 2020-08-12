Rails.application.routes.draw do
  resources :comments do 
    resources :likes
  end
  devise_for :users, :path => 'u'
  resources :users do
    resources :posts
    resources :requests
    resource :page
  end
  resources :posts do
    resources :likes
  end
  get "/requests/friends", to: "requests#friends"
  get "/requests/accept", to: "requests#accept"
  get "/requests/deny", to: "requests#deny"
  get "/likes/comment_create", to: "likes#comment_create"
  get "/likes/comment_destroy", to: "likes#comment_destroy"
  root "posts#index"
  resources :requests, only: [:new, :index, :create]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
