Rails.application.routes.draw do
  resources :books
  devise_for :users
  get 'welcome', to: 'home#welcome'
  root 'books#index'
  
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
