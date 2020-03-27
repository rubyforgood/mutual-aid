Rails.application.routes.draw do
  scope "/:zip_code/" do
    resources :listings
  end
end
