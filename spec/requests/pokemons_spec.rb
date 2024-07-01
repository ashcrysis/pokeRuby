require 'rails_helper'
require 'vcr'

RSpec.describe PokemonsController, type: :request do
  before do
    allow_any_instance_of(PokemonsController).to receive(:authenticate_user!).and_return(true)
  end

  describe "POST /v2/pokemons/create" do
    context "with valid params" do
      it 'creates a new pokemon' do
        pokemon_params = {
          pokemon: {
            nome: "Pikachu",
            moves: ["Thunderbolt", "Quick Attack"],
            tipo: "Electric",
            imagem: "https://example.com/pikachu.png"
          }
        }

        expect { post "/v2/pokemons/create", params: pokemon_params }.to change(Pokemon, :count).by(1)
        expect(response).to have_http_status(:created)
      end
    end

    context "with invalid params" do
      it 'renders 422 error for invalid pokemon' do
        pokemon_params = {
          pokemon: {
            nome: nil,
            moves: nil,
            tipo: nil,
            imagem: nil
          }
        }

        expect { post "/v2/pokemons/create", params: pokemon_params }.to change(Pokemon, :count).by(0)
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe "GET /v2/pokemons/list", :vcr do
    it 'returns a list of all pokemons' do
      get "/v2/pokemons/list"

      expect(response).to have_http_status(:ok)

      parsed_response = JSON.parse(response.body)
      expect(parsed_response.size).to eq(Pokemon.count)
    end
  end

  describe "GET /v2/pokemons/search", :vcr do
    it 'returns a pokemon based on param' do
      pokemon = { name: "pikachu" }
      get "/v2/pokemons/search", params: pokemon
      expect(response).to have_http_status(:ok)

      parsed_response = JSON.parse(response.body)
      expect(parsed_response['name']).to eq(pokemon[:name])
    end

    it 'returns bad request for a number instead of a name' do
      invalid_pokemon = { name: 4 }
      get "/v2/pokemons/search", params: invalid_pokemon
      expect(response).to have_http_status(:bad_request)

      parsed_response = JSON.parse(response.body)
      expect(parsed_response['error']).to eq("Invalid Pokémon name")
    end
  end
end
