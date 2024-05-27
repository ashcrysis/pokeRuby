Rails.application.routes.draw do
  get 'favorites/create'
  get 'favorites/index'
  root "search#pokelist"

  scope '/v1' do
    get "/pokemon", to: "pokemon#index"
    get "/search", to: "search#pokelist"
    get "/", to: "search#pokelist"
  end
  scope '/v2' do
    get "/", to: "favorites#all"
  end
  resources :pokemon, only: [:index, :show]
  resources :favorites, only: [:create, :index]
  delete 'favorites/clear', to: 'favorites#clear', as: 'clear_favorites'
end
