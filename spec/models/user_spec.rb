require 'rails_helper'

RSpec.describe User, type: :model do

  it 'returns user name' do
    user = User.create(email: "teste@email", nome: "Asher", password: "password123")
    expect(user.nome).to eq "Asher"
  end

  it 'validates user name not nil' do
    user = User.new(email: "teste@email", password: "password123")
    expect(user.valid?).to be false
    expect(user.errors[:nome]).to include("can't be blank")
  end

  it 'validates user password not nil' do
    user = User.new(email: "teste@email", nome: "Asher")
    expect(user.valid?).to be false
    expect(user.errors[:password]).to include("can't be blank")
  end

  it 'validates user email unique' do
    user1 = User.create(email: "teste@email", nome: "Asher", password: "password123")
    user2 = User.new(email: "teste@email", nome: "Asher2", password: "password1234")
    expect(user2.valid?).to be false
    expect(user2.errors[:email]).to include("has already been taken")
  end

  it 'validates user email presence' do
    user = User.new(nome: "Asher", password: "password123")
    expect(user.valid?).to be false
    expect(user.errors[:email]).to include("can't be blank")
  end

end
