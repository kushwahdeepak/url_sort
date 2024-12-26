Rails.application.routes.draw do
  root "dev_urls#new"
  resources :dev_urls, only: [:new, :create, :show]
  get '/:short', to: 'dev_urls#redirect', as: :short
# for api
  namespace :api do
    resources :dev_urls, only: [:create]
  end
end
