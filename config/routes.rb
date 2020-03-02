Rails.application.routes.draw do
  root 'home#index'
  resources :urls, only: :create
  get ':short_path', to: 'redirect#show'
end
