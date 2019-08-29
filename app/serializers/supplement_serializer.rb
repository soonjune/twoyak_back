class SupplementSerializer
  include FastJsonapi::ObjectSerializer
  attributes :shopping_site, :name, :product_url, :photo_url, :rating, :shoppingmall_reviews
  attribute :rankings do |sup|
    SupplementIngrsSupplementSerializer.new(sup.rankings).serialized_json
  end
end
