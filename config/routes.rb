Rails.application.routes.draw do
  root "search#pokelist"

  get "/pokemon", to: "pokemon#index"
  get "/search", to: "search#pokelist"
end
