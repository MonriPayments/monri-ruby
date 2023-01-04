module Monri
  class AccessTokens

    # @return [Monri::Config]
    attr_accessor :config

    # @return [Monri::HttpClient]
    attr_writer :http_client

    def create(options)
      body = {
        client_id: config.authenticity_token,
        client_secret: config.merchant_key,
        grant_type: 'client_credentials',
        scopes: options.delete(:scopes) || []
      }
      response = @http_client.post('/v2/oauth', body)
      # TODO: do we set exception?
      if response.success?
        response.body
      else
        # TODO: handle this case
      end
    end
  end
end