Rails.application.routes.draw do
  resources :urls, only: :create
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  get ':short_path', to: 'redirect#show'
end
