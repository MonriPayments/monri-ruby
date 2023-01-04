module Monri
  class Payments
    # @return [Monri::Config]
    attr_accessor :config
    # @return [Monri::HttpClient]
    attr_writer :http_client

    # @return [Monri::AccessTokens]
    attr_writer :access_tokens

    # @param [Hash] options
    def create(options)
      @access_tokens.create(scopes: options[:scopes])
    end
  end
end