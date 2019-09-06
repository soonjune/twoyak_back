class ContentSerializer
  include FastJsonapi::ObjectSerializer
  attributes :category, :title, :body
  attribute :thumbnail_url do |object|
    url_for(object.thumbnail_image)
  end
end
