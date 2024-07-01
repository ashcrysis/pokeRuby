class User < ApplicationRecord
  include Devise::JWT::RevocationStrategies::JTIMatcher
  devise :database_authenticatable, :registerable, :recoverable, :validatable,
   :jwt_authenticatable, jwt_revocation_strategy: self
   self.skip_session_storage = [:http_auth, :params_auth]

   has_many :favorites
   validates :nome, presence: true
   validates :password, presence: true
   validates :email, presence: true, uniqueness: true

end
