require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  describe 'GET #list' do
    it 'returns a success response and a list of users' do
      user1 = User.create!(email: "usuario1@example.com", nome: "usuario1", password: "12345678")
      user2 = User.create!(email: "usuario2@example.com", nome: "usuario2", password: "12345678")

      get :list

      expect(response).to be_successful
      expect(response.content_type).to eq('application/json; charset=utf-8')

      json_response = JSON.parse(response.body)
      expect(json_response.size).to eq(2)
      expect(json_response[0]['email']).to eq(user1.email)
      expect(json_response[1]['email']).to eq(user2.email)
    end
  end
end
