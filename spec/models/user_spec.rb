require 'rails_helper'

RSpec.describe User, type: :model do
  it 'returns user name' do
    user = User.create(email: "teste@email", nome: "Asher")
    expect(user.nome).to eq "Asher"
  end
end
