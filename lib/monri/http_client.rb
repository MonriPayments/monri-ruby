module Monri
  class HttpClient

    # @return [Monri::Config]
    attr_accessor :config

    # @param [String] url
    # @param [Hash] options
    # @return [Monri::ApiHttpResponse]
    def get(url, options = {})
      # TODO: validate
      uri = build_url(url)
      headers = prepare_headers(options)
      # Create the HTTP objects
      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = true
      request = Net::HTTP::Get.new(uri.request_uri, headers)
      # Send the request
      response = http.request(request)
      ApiHttpResponse.new.from_net(response)
    end

    # @param [String] url
    # @param [Hash] body
    # @param [Hash] options
    # @return [Monri::ApiHttpResponse]
    def post(url, body, options = {})
      # TODO: validate
      uri = build_url(url)
      headers = prepare_headers(options)
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
    def build_url(url)
      URI.parse("#{config.base_api_url}#{url}")
    end

    private

    # @param [Hash] options
    # @return [Hash{Symbol->String}]
    def prepare_headers(options)
      req_headers = options.delete(:headers) || {}
      headers = {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'x-request-id': SecureRandom.hex
      }

      if options.has_key?(:oauth)
        headers['Authorization'] = "Bearer #{options.delete(:oauth)}"
      end

      headers.merge!(req_headers)
      headers
    end

  end
end