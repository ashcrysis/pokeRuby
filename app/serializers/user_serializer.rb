class UserSerializer
  include JSONAPI::Serializer
  attributes :id, :email, :name, :phone, :postal_code, :street, :number, :complement
end
