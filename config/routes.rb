Rails.application.routes.draw do
  root "pokemon#index"

  get "/pokemon", to: "pokemon#index"
  get "/search", to: "search#pokelist"
end
