class ContentSerializer
  include FastJsonapi::ObjectSerializer
  attributes :title, :thumbnail_url
end
