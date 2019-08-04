require "faraday_middleware/aws_signers_v4"

class AmazonElasticSearchClient
  def self.client
    return Elasticsearch::Client.new(url: ENV["AWS_ELASTICSEARCH_URL"]) do |f|
      f.request :aws_signers_v4,
                service_name: 'es',
                credentials: Aws::Credentials.new(ENV["AWS_ACCESS_KEY_ID"], ENV["AWS_SECRET_ACCESS_KEY"]),
                region: ENV["AWS_REGION"],
                # This is standard for Net::HTTP, if you
                # you are using another client with Faraday,
                # it might be configured using other keys.
                timeout: 20,
                open_timeout: 10
    end
  end
end

# We use AWS_ELASTICSEARCH_URL instead of ELASTICSEARCH_URL
# as we alsow want to support environments that are not
# connecting to a AWS ES endpoint.
Elasticsearch::Model.client = AmazonElasticSearchClient.client unless ENV["AWS_ELASTICSEARCH_URL"].blank?