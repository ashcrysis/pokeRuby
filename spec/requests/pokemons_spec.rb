require 'rails_helper'

RSpec.describe PokemonsController, type: :request do
  describe "POST /v2/pokemons/create" do
    before do
      allow_any_instance_of(PokemonsController).to receive(:authenticate_user!).and_return(true)
    end

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
      it 'renders 400 error a new pokemon' do
        pokemon_params = {
          pokemon: {
          }
        }

        expect { post "/v2/pokemons/create", params: pokemon_params }.to change(Pokemon, :count).by(0)
        expect(response).to have_http_status(:bad_request)
      end
    end
  end
end

=begin

{
  "pokemon": {
    "nome": "Pikachu",
    "moves": "Thunderbolt", "Quick Attack",
    "tipo": "Electric",
    "imagem": "https://example.com/pikachu.png"
  }
}
=end
