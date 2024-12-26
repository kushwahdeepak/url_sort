Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'
  root "dev_urls#new"
  resources :dev_urls, only: [:new, :create, :show]
  get '/:short_url', to: 'dev_urls#redirect', as: :short
# for api
  namespace :api do
    resources :dev_urls, only: [:create]
  end
end
