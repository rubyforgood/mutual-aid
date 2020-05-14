Rails.application.routes.draw do

  resources :teams
  devise_for :users

  get "/admin",                    to: "admin#landing_page",    as: "landing_page_admin"
  get "/admin/volunteers",         to: "admin#volunteer_admin", as: "volunteer_admin"
  get "/glossary",                 to: "admin#glossary",        as: "glossary_admin"
  get "/yearbook",                 to: "admin#yearbook",        as: "yearbook_admin"

  get "/public",                   to: "public_pages#landing_page",        as: "landing_page_public"
  get "/about",                    to: "public_pages#about",               as: "about_public"
  get "/announcements_list",       to: "public_pages#announcements",       as: "announcements_public"
  get "/community_resources_list", to: "public_pages#community_resources", as: "community_resources_public"
  get "/combined_form",            to: "public_pages#combined_form",       as: "combined_form_public"
  get "/contributions",            to: "public_pages#contributions",       as: "contributions_public" # TODO remove this
  get "/thank_you",                to: "public_pages#submission_thank_you", as: "submission_thank_you"

  resources :announcements
  resources :asks, only: [:index, :edit, :update, :new, :create]
  resources :categories
  resources :communication_logs
  resources :community_resources
  resources :contact_methods
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
  resources :organizations
  resources :people
  resources :positions
  resources :shared_accounts
  resources :service_areas
  resources :software_feedbacks
  resources :submissions
  resources :submission_responses
  resources :system_locales
  resources :system_settings
  resources :users

  root :to => 'public#landing_page'
end
