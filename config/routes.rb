Rails.application.routes.draw do
  get 'comments/create'
  get 'comments/destroy'
  devise_for :users
  root "posts#index"  
  resources :posts
end


