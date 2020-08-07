Rails.application.routes.draw do
  resources :comments
  devise_for :users, :path => 'u'
  resources :users do
    resources :posts
  end
  resources :posts
  root "posts#index"
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
