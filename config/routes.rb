Rails.application.routes.draw do
  root "pokemon#index"

  get "/pokemon", to: "pokemon#index"
end
