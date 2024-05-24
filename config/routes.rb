Rails.application.routes.draw do
  root "search#pokelist"

  scope '/v1' do
    get "/pokemon", to: "pokemon#index"
    get "/search", to: "search#pokelist"
    get "/", to: "search#pokelist"
  end
end
