Rails.application.routes.draw do
  root 'urls#index'
  resources :urls, only: [:index, :new, :create, :show]
end
