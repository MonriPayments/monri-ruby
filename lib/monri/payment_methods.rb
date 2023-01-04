module Monri
  class PaymentMethods
    # @return [Monri::Config]
    attr_accessor :config
    # @return [Monri::HttpClient]
    attr_writer :http_client

    # @return [Monri::AccessTokens]
    attr_writer :access_tokens

    # @param [Hash] options
    def list(options = {})
      access_token = @access_tokens.create(scopes: ['payment-methods'])[:access_token]
      response = @http_client.get('/v2/payment-methods', headers: { 'Authorization' => "Bearer #{access_token}" })
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