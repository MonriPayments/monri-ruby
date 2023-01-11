# frozen_string_literal: true

require 'forwardable'
module Monri
  class Client
    extend Forwardable

    def initialize
      @config = Monri::Config.new
    end

    def_delegators :@config, :merchant_key, :authenticity_token, :environment
    def_delegators :@config, :merchant_key=, :authenticity_token=, :environment=

    # @return [Monri::Payments]
    def payments
      @payments ||= create_payment_api
    end

    # @return [Monri::AccessTokens]
    def access_tokens
      @access_tokens ||= create_access_tokens_api
    end

    # @return [Monri::Customers]
    def customers
      @customers ||= create_customers_api
    end

    # @return [Monri::PaymentMethods]
    def payment_methods
      @payment_methods ||= create_payment_methods_api
    end

    private

    def ensure_config_set!
      unless @config.configured?
        raise Monri::Config::InvalidConfiguration, 'Configuration is not set! Did you call .merchant_key=merchant_key, .authenticity_token=authenticity_token, .environment=environment'
      end
    end

    def http_client
      if @http_client == nil
        @http_client = Monri::HttpClient.new
        @http_client.config = @config
      end

      @http_client
    end

    def create_customers_api
      ensure_config_set!
      rv = Monri::Customers.new
      rv.config = @config
      rv.http_client = http_client
      rv.access_tokens = access_tokens
      rv
    end

    def create_access_tokens_api
      ensure_config_set!
      rv = Monri::AccessTokens.new
      rv.config = @config
      rv.http_client = http_client
      rv
    end

    def create_payment_api
      ensure_config_set!
      rv = Monri::Payments.new
      rv.config = @config
      rv.http_client = http_client
      rv.access_tokens = access_tokens
      rv
    end

    def create_payment_methods_api
      ensure_config_set!
      rv = Monri::PaymentMethods.new
      rv.config = @config
      rv.http_client = http_client
      rv.access_tokens = access_tokens
      rv
    end
  end
end
