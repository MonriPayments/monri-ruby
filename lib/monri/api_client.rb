module Monri
  class ApiClient
    # @param [String] url
    # @param [Hash] body
    # @return [Monri::ApiHttpResponse]
    def self.post(url, body)
      # TODO: validate
      uri = build_url(url)
      body_as_string = body.to_json
      headers = {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': authorization_header(uri, body_as_string),
        'x-request-id': SecureRandom.hex
      }
      # Create the HTTP objects
      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = true
      request = Net::HTTP::Post.new(uri.request_uri, headers)
      request.body = body.to_json
      # Send the request
      response = http.request(request)
      ApiHttpResponse.new.from_net(response)
    end

    # @param [String] url
    # @return [URI]
    def self.build_url(url)
      URI.parse("#{Monri.config.base_api_url}#{url}")
    end

    # @param [URI] uri
    # @param [String] body
    def self.authorization_header(uri, body)
      timestamp = Time.now.to_i
      digest = Digest::SHA512.hexdigest("#{Monri.api_key}#{timestamp}#{Monri.api_account}#{uri.path}#{body}")
      "WP3-v2.1 #{Monri.api_account} #{timestamp} #{digest}"
    end
  end
end