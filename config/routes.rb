Rails.application.routes.draw do

  devise_for :users

  get "/admin", to: "admin#landing_page", as: "landing_page_admin"
  get "/admin/volunteers", to: "admin#volunteer_admin", as: "volunteer_admin"
  get "/yearbook", to: "admin#yearbook", as: "yearbook_admin"

  get "/public", to: "public#landing_page", as: "landing_page_public"
  get "/about", to: "public#about", as: "about_public"
  get "/community_resources_list", to: "public#community_resources", as: "community_resources_public"
  get "/news", to: "public#news_and_announcements", as: "news_and_announcements_public"
  get "/share", to: "public#share", as: "share_public"

  resources :listings do
    member do
      get "/match", to: "listings#match", as: "match_listing"
      post "/match", to: "listings#match"
      get "/match/confirm", to: "listings#confirm_match", as: "confirm_match_listing"
      post "/match/confirm", to: "listings#confirm_match"
    end
    collection do
      resources :offers
      resources :asks
    end
  end

  resources :announcements
  resources :communication_logs
  resources :donations
  resources :external_resources
  resources :locations
  resources :matches
  resources :organizations
  resources :people
  resources :positions
  resources :shared_accounts
  resources :system_locations
  resources :system_settings
  resources :system_tags
  resources :users

  authenticated :user do
    root :to => 'admin#landing_page', as: :authenticated_root
  end

  root :to => 'public#landing_page'
end
