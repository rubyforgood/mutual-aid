Rails.application.routes.draw do
  devise_for :users

  resources :external_resources
  resources :listings

  resources :public, only: [:landing_page]

  authenticated :user do
    root :to => 'admin#landing_page', as: :authenticated_root
  end

  root :to => 'public#landing_page'
end
