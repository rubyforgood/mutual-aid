Rails.application.routes.draw do
  devise_for :users

  resources :external_resources

  resources :listings

  resource :landing_page, only: [:show]

  root to: "landing_page#show"
end
