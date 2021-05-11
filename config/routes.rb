Rails.application.routes.draw do
  resources :books do
    resources :borrows
  end
  devise_for :users
  get 'welcome', to: 'home#welcome'
  root 'books#index'
  resources :admin
  get 'approved', to: 'admin#approved'
  
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
