class UserSerializer
  include JSONAPI::Serializer
  attributes :id, :email, :nome
end
