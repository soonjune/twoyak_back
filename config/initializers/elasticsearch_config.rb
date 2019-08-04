require 'faraday_middleware/aws_signers_v4'

ENV['ELASTICSEARCH_URL'] = "https://vpc-twoyak-tgdpdr7k4moi4flysnhc4lsosu.ap-northeast-2.es.amazonaws.com"

Searchkick.client = Elasticsearch::Client.new(url: ENV['ELASTICSEARCH_URL']) do |f|
  f.request :aws_signers_v4,
            credentials: Aws::Credentials.new(ENV['AWS_ACCESS_KEY_ID'], ENV['AWS_SECRET_ACCESS_KEY']),
            service_name: 'es',
            region: ENV['AWS_REGION']
end
