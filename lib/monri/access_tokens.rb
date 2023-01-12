module Monri
  class AccessTokens

    # @return [Monri::Config]
    attr_accessor :config

    # @return [Monri::HttpClient]
    attr_writer :http_client

    # @param [Hash] options
    # @return [Monri::AccessTokens::CreateResponse]
    def create!(options)
      rv = create(options)
      if rv.failed?
        #noinspection RubyMismatchedArgumentType
        raise rv.exception
      end
      rv
    end

    # @param [Hash] options
    # @return [Monri::AccessTokens::CreateResponse]
    def create(options)
      Monri::AccessTokens::CreateResponse.create do
        body = {
          client_id: config.authenticity_token,
          client_secret: config.merchant_key,
          grant_type: 'client_credentials',
          scopes: options.delete(:scopes) || []
        }
        response = @http_client.post('/v2/oauth', body)
        if response.failed?
          raise response.exception
        elsif response.success?
          response.body
        else
          # TODO: handle this case
        end
      end

    end
  end
end