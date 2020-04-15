Rails.application.routes.draw do
  resources :organizations
  resources :system_settings
  resources :donations
  resources :positions
  resources :shared_accounts
  resources :announcements
  resources :communication_logs
  resources :people
  resources :locations
  resources :system_tags

  devise_for :users

  resources :external_resources
  resources :listings do
    member do
      resources :match
    end
    collection do
      resources :offers
      resources :asks
    end
  end

  resources :admin, only: [:landing_page]
  resources :public, only: [:landing_page, :community_resources]

  authenticated :user do
    root :to => 'admin#landing_page', as: :authenticated_root
  end

  root :to => 'public#landing_page'
end
