Rails.application.routes.draw do

  devise_for :users

  resources :listings

  root to: "listings#index"
end
