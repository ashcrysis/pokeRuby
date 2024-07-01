require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  describe 'GET #list' do
    it 'returns a success response and a list of users' do

      get :list

      expect(response).to be_successful
      expect(response.content_type).to eq('application/json; charset=utf-8')

      json_response = JSON.parse(response.body)
      expect(json_response.size).to eq(User.all.length)
    end
  end
end
