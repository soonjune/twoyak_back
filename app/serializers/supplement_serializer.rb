class SupplementSerializer
  include FastJsonapi::ObjectSerializer
  attributes :shopping_site, :name, :enterprise_name, :price, :product_url, :photo_url, :rating, :shoppingmall_reviews
  attribute :rankings do |sup|
    SupplementIngrsSupplementSerializer.new(sup.rankings).serialized_json
  end
end
