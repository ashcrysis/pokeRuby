class User < ApplicationRecord
  include Devise::JWT::RevocationStrategies::JTIMatcher
  devise :database_authenticatable, :registerable, :recoverable, :validatable,
   :jwt_authenticatable, jwt_revocation_strategy: self
   self.skip_session_storage = [:http_auth, :params_auth]

   has_many :favorites
   validates :name, presence: true
   validates :password, presence: true, on: :create
   validates :email, presence: true, uniqueness: true

   has_one_attached :image
end
