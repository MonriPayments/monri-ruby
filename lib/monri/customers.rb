module Monri
  class Customers
    # @return [Monri::Config]
    attr_accessor :config
    # @return [Monri::HttpClient]
    attr_writer :http_client
    # @return [Monri::AccessTokens]
    attr_writer :access_tokens

    # @param [Hash] options
    def create(options)
      access_token = @access_tokens.create(scopes: ['customers'])[:access_token]
      response = @http_client.post('/v2/customers', options, headers: { 'Authorization' => "Bearer #{access_token}" })
      if response.success?
        response.body
      else
        # TODO: handle this case
      end
    rescue StandardError => e
      # TODO: handle this case
      nil
    end
  end
end