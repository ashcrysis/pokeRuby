require 'rails_helper'
require 'devise'
require 'vcr'

RSpec.describe PokemonsController, type: :controller do
  before do
    @request.env["devise.mapping"] = Devise.mappings[:user]
    user = create(:user)
    sign_in user
  end

  describe 'GET #search', :vcr do
    it 'returns a Pokemon when a valid name is provided' do
      get :search, params: { name: 'pikachu' }
      expect(response).to have_http_status(:success)
      json_response = JSON.parse(response.body)
      expect(json_response['name']).to eq('pikachu')
    end
  end

  describe 'GET #fetch_all_pokemon_data', :vcr do
    it 'returns a list of all Pokemon' do
      get :fetch_all_pokemon_data
      expect(response).to have_http_status(:success)
      json_response = JSON.parse(response.body)
      expect(json_response['results'].size).to be > 0
    end
  end
end
