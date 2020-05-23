Rails.application.routes.draw do

  devise_for :users

  get "/admin",                    to: "admin#landing_page",    as: "landing_page_admin"
  get "/admin/volunteers",         to: "admin#volunteer_admin", as: "volunteer_admin"
  get "/glossary",                 to: "admin#glossary",        as: "glossary_admin"
  get "/yearbook",                 to: "admin#yearbook",        as: "yearbook_admin"

  get "/public",                   to: "public_pages#landing_page",        as: "landing_page_public"
  get "/about",                    to: "public_pages#about",               as: "about_public"
  get "/announcements_list",       to: "public_pages#announcements",       as: "announcements_public"
  get "/community_resources_list", to: "public_pages#community_resources", as: "community_resources_public"
  # get "/contributions",            to: "public_pages#contributions",       as: "contributions_public" # TODO remove this

  resources :announcements
  resources :asks, only: [:index, :edit, :update, :new, :create]
  resources :categories
  resources :communication_logs do
    collection do
      post "/create_remote", to: "communication_logs#create_remote", as: "create_remote"
    end
  end
  resources :community_resources
  resources :contact_methods
  get "/combined_form", to: "contributions#combined_form", as: "combined_form"
  get "/thank_you", to: "contributions#thank_you", as: "contribution_thank_you"
  resources :contributions, only: [:index] do
    member do
      get "/respond", to: "contributions#respond", as: "respond"
    end
  end
  resources :custom_form_questions
  resources :donations
  resources :feedbacks
  resources :history_logs, only: [:index]
  resources :location_types
  get "/listings_index", to: "listings#listings_index", as: "listings_index_list"
  resources :listings do
    member do
      get "/match", to: "listings#match", as: "match_listing"
      post "/match", to: "listings#match"
      get "/match/confirm", to: "listings#match_confirm", as: "match_confirm_listing"
      post "/match/confirm", to: "listings#match_confirm"
    end
  end
  resources :locations
  resources :matches
  resources :mobility_string_translations
  resources :offers, only: [:index, :edit, :update, :new, :create]
  get "/org_chart", to: "organizations#org_chart", as: "org_chart"
  resources :organizations
  resources :people
  resources :positions
  resources :service_areas
  resources :shared_accounts
  resources :shifts
  resources :shift_matches
  resources :software_feedbacks
  resources :submissions
  resources :submission_responses
  resources :system_locales
  resources :system_settings
  resources :teams
  resources :users

  root :to => 'public#landing_page'
end
