ENV['ELASTICSEARCH_URL'] = "https://vpc-twoyak-tgdpdr7k4moi4flysnhc4lsosu.ap-northeast-2.es.amazonaws.com"
Searchkick.aws_credentials = {
  access_key_id: ENV['AWS_ACCESS_KEY_ID'],
  secret_access_key: ENV['AWS_SECRET_ACCESS_KEY'],
  region: ENV['AWS_REGION']
}