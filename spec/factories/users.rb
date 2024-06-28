FactoryBot.define do
  factory :user do
    sequence(:email) { |n| "usuario#{n}@example.com" }
    nome { "Asher" }
    password { "password123" }
    password_confirmation { "password123" }
  end
end
