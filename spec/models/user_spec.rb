require 'rails_helper'

RSpec.describe User, type: :model do

    it 'returns user name' do
      user = create(:user, nome: "Asher")
      expect(user.nome).to eq "Asher"
    end

    it 'validates user name not nil' do
      user = build(:user, nome: nil)
      expect(user.valid?).to be false
      expect(user.errors[:nome]).to include("can't be blank")
    end

    it 'validates user password not nil' do
      user = build(:user, password: nil)
      expect(user.valid?).to be false
      expect(user.errors[:password]).to include("can't be blank")
    end

    it 'validates user email unique' do
      user1 = create(:user, email: "unique@example.com")
      user2 = build(:user, email: "unique@example.com")
      expect(user2.valid?).to be false
      expect(user2.errors[:email]).to include("has already been taken")
    end

    it 'validates user email presence' do
      user = build(:user, email: nil)
      expect(user.valid?).to be false
      expect(user.errors[:email]).to include("can't be blank")
    end
  end
