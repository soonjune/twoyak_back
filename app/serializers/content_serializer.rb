class ContentSerializer
  include FastJsonapi::ObjectSerializer
  attributes :category, :title, :body
  attribute :thumbnail_url do |object|
    object.thumbnail_image.service_url
  end
end
