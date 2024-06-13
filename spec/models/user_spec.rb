require 'rails_helper'

RSpec.describe User, type: :model do

  it 'returns user name' do
    user = User.create(email: "teste@email", nome: "Asher")
    expect(user.nome).to eq "Asher"
  end

  it 'validates user not nil' do
    user = User.create(email: "teste@email")
    expect(user.nome).not_to be_nil
  end

  it 'validates user password not nil' do
    user = User.create(email: "teste@email")
    expect(user.password).not_to be_nil
  end

  it 'validates user email unique' do
    user1 = User.create(email: "teste@email")
    user2 = User.create(email: "teste@email")
    expect(User.exists?(user1.email)).to be true
    expect(User.exists?(user2.email)).to be false
  end

end
