Rails.application.routes.draw do
  root "pokemons#list"
  devise_for :users, path: '', path_names: {
    sign_in: 'login',
    sign_out: 'logout',
    registration: 'signup'
  },
  controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }

  scope '/v2' do
    scope '/users' do
      post "/create", to: "users#create"
      put "/update/:id", to: "users#update"
      delete "/destroy/:id", to: "users#destroy"
      get "/list", to: "users#list"
      get "/current", to: "users#current"
    end

    scope '/pokemons' do
      get "/search", to: "pokemons#search"
      get "/fetch_all", to: "pokemons#fetch_all_pokemon_data"
      get "/species", to: "pokemons#species"

      get "/toggle_api", to: "pokemons#toggle_api"
    end

    scope '/favorites' do
      post "/create", to: "favorites#create"
      put "/update/:id", to: "favorites#update"
      delete "/destroy/:id", to: "favorites#destroy"
      get "/list", to: "favorites#list"
      get "/user_favorites_list", to: "favorites#get_user_favorites"
    end

  end

end
