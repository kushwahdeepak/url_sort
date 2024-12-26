Rails.application.routes.draw do
  root "urls#new"
  resources :urls, only: [:new, :create]
end
