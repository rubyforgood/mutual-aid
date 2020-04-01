Rails.application.routes.draw do

  resources :external_resources
  devise_for :users

  resources :listings

  root to: "listings#index"
end
