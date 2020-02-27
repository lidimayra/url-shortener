Rails.application.routes.draw do
  root 'home#index'
  resources :urls, only: %i[index create]
  get ':short_path', to: 'redirect#show'
end
