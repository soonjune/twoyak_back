# Be sure to restart your server when you modify this file.

# Avoid CORS issues when API is called from the frontend app.
# Handle Cross-Origin Resource Sharing (CORS) in order to accept cross-origin AJAX requests.

# Read more: https://github.com/cyu/rack-cors

Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
    origins #관리자 페이지
            'mvponstreet.s3-website.ap-northeast-2.amazonaws.com',
            /\Ahttp:\/\/163\.152\.83\.\168(:\d+)?\z/

    resource '*',
      headers: :any,
      methods: [:get, :post, :put, :patch, :delete, :options, :head],
      expose: ['Total-Count']
  end

allow do
  origins 'twoyak.com'
  resource '*', headers: :any, methods: [:get, :post, :put, :patch, :delete, :options, :head]

  # Only allow a request for a specific host
  resource '*',
      headers: :any,
      methods: [:get, :post, :put, :patch, :delete, :options, :head],
      if: proc { |env| env['HTTP_HOST'] == 'api.twoyak.com' }
  end
end

# Rails.application.config.middleware.insert_before 0, Rack::Cors do
#   allow do
#     origins 'http://api.twoyak.com'
#     resource '/api/*',
#       headers: %w(Authorization),
#       methods: :any,
#       expose: %w(Authorization),
#       max_age: 600
#   end
# end