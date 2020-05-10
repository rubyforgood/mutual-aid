Rails.application.routes.draw do

  devise_for :users

  get "/admin", to: "admin#landing_page", as: "landing_page_admin"
  get "/admin/volunteers", to: "admin#volunteer_admin", as: "volunteer_admin"
  get "/yearbook", to: "admin#yearbook", as: "yearbook_admin"

  get "/public", to: "public#landing_page", as: "landing_page_public"
  get "/about", to: "public#about", as: "about_public"
  get "/community_resources_list", to: "public#community_resources", as: "community_resources_public"
  get "/announcements_list", to: "public#announcements", as: "announcements_public"
  get "/share", to: "public#share", as: "share_public"

  resources :listings do
    member do
      get "/match", to: "listings#match", as: "match_listing"
      post "/match", to: "listings#match"
      get "/match/confirm", to: "listings#match_confirm", as: "match_confirm_listing"
      post "/match/confirm", to: "listings#match_confirm"
    end
  end

  resources :offers, only: [:new, :create]

  resources :announcements
  resources :categories
  resources :communication_logs
  resources :community_resources
  resources :contact_methods
  resources :custom_form_questions
  resources :donations
  resources :feedbacks
  resources :locations
  resources :matches
  resources :mobility_string_translations
  resources :organizations
  resources :people
  resources :positions
  resources :shared_accounts
  resources :service_areas
  resources :software_feedbacks
  resources :submissions
  resources :system_locales
  resources :system_settings
  resources :users

  root :to => 'public#landing_page'
end
