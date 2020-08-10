Rails.application.routes.draw do
  resources :comments
  devise_for :users, :path => 'u'
  resources :users do
    resources :posts
  end
  resources :posts do
    resources :likes
  end
  root "posts#index"
  resources :requests, only: [:new, :index, :create]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
