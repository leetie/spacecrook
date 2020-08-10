Rails.application.routes.draw do
  resources :comments
  devise_for :users, :path => 'u'
  resources :users do
    resources :posts
    resources :requests
  end
  resources :posts do
    resources :likes
  end
  get "/requests/accept", to: "requests#accept"
  get "/requests/deny", to: "requests#deny"
  root "posts#index"
  resources :requests, only: [:new, :index, :create]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
