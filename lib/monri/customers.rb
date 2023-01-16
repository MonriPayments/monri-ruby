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
      CreateResponse.create do
        token_rv = @access_tokens.create!(scopes: ['customers'])
        response = @http_client.post('/v2/customers', options, oauth: token_rv.access_token)

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