Rails.application.routes.draw do
  root "pokemons#list"
  devise_for :users, controllers: {
    sessions: 'users/sessions'
  }
  devise_scope :user do
    scope '/v2/users' do
      post "/sign_in", to: "users/sessions#create"
    end
  end

  scope '/v2' do
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

    scope '/favorites' do
      post "/create", to: "favorites#create"
      put "/update/:id", to: "favorites#update"
      delete "/destroy/:id", to: "favorites#destroy"
      get "/list", to: "favorites#list"
      get "/user_favorites_list", to: "favorites#get_user_favorites"
    end

  end

end
