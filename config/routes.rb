Rails.application.routes.draw do
  get 'comments/create'
  get 'comments/destroy'
  devise_for :users
  get 'posts/index'
  root "posts#index"  
end


