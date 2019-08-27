url = "https://vpc-twoyak-tgdpdr7k4moi4flysnhc4lsosu.ap-northeast-2.es.amazonaws.com"
    Elasticsearch::Model.client = Elasticsearch::Client.new url: url
  Searchkick.client = Elasticsearch::Client.new(hosts: url, retry_on_failure: true, transport_options: {request: {timeout: 250}})

  