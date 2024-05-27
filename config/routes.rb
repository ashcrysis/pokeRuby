Rails.application.routes.draw do
  root "pokemons#list"
  scope '/v2' do
    get "/", to: "favorites#all"
    scope '/users' do
      post "/create", to: "users#create"
      put "/update/:id", to: "users#update"
      delete "/destroy/:id", to: "users#destroy"
      get "/list", to: "users#list"
    end
    scope '/pokemons' do
      post "/create", to: "pokemons#create"
      put "/update/:id", to: "pokemons#update"
      delete "/destroy/:id", to: "pokemons#destroy"
      get "/list", to: "pokemons#list"
      get "/search", to: "pokemons#search"
    end
  end

end
