class UserSerializer
  include JSONAPI::Serializer
  attributes :id, :email, :name, :phone, :postal_code, :street, :number, :complement

  attribute :image_url do |user|
    Rails.application.routes.url_helpers.url_for(user.image) if user.image.attached?
  end
end
