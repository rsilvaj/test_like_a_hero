Rails.application.routes.draw do

  resources :users, only: [:index, :create]
  resources :weapons, only: [:index, :create, :show, :destroy]
  resources :enemies

end
