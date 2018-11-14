if Rails.env == "production"
    url = "https://vpc-twoyak-fve2u4dzywn3fodzbfrryzxusi.ap-northeast-2.es.amazonaws.com"
      Elasticsearch::Model.client = Elasticsearch::Client.new url: url
    Searchkick.client = Elasticsearch::Client.new(hosts: url, retry_on_failure: true, transport_options: {request: {timeout: 250}})
else
    url = 'http://localhost:9200/'
      Elasticsearch::Model.client = Elasticsearch::Client.new url: url
    Searchkick.client = Elasticsearch::Client.new(hosts: url, retry_on_failure: true, transport_options: {request: {timeout: 250}})
end