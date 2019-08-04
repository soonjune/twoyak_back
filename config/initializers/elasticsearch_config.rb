require 'faraday_middleware/aws_signers_v4'

client = Elasticsearch::Client.new url: ENV['ELASTICSEARCH_URL'] do |f|
  f.request :aws_signers_v4,
            credentials: Aws::Credentials.new(ENV['AWS_ACCESS_KEY'], ENV['AWS_SECRET_ACCESS_KEY']),
            service_name: 'es',
            region: ENV['AWS_REGION']
end