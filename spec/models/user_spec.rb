require 'rails_helper'

RSpec.describe User, type: :model do

    context "when name is correct" do
    it 'returns user name' do
      user = create(:user, name: "Asher")
      expect(user.name).to eq "Asher"
    end
    end

    context "when user name is nil" do
    it 'return error' do
      user = build(:user, name: nil)
      expect(user.valid?).to be false
      expect(user.errors[:name]).to include("can't be blank")
    end
    end

    context "when password is nil" do
    it 'return error' do
      user = build(:user, password: nil)
      expect(user.valid?).to be false
      expect(user.errors[:password]).to include("can't be blank")
    end
  end

    context "when user email alrealdy exists on db" do
    it 'return error' do
      create(:user, email: "unique@example.com")
      user2 = build(:user, email: "unique@example.com")
      expect(user2.valid?).to be false
      expect(user2.errors[:email]).to include("has already been taken")
    end
  end

  context "when user email is nil" do
    it 'return error' do
      user = build(:user, email: nil)
      expect(user.valid?).to be false
      expect(user.errors[:email]).to include("can't be blank")
    end
  end
  end
