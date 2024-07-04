class UserSerializer
  include JSONAPI::Serializer
  attributes :id, :email, :name, :phone, :postal_code, :street, :number, :complement

  attribute :image_blob do |user|
    if user.image.attached?
      {
        url: Rails.application.routes.url_helpers.rails_blob_path(user.image, only_path: true),
        content_type: user.image.content_type,
        filename: user.image.filename.to_s,
        byte_size: user.image.byte_size,
      }
    end
  end
end
