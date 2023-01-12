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

    # @return [Monri::Tokens]
    def tokens
      @tokens ||= create_tokens_api
    end

    # @return [Monri::Transactions]
    def transactions
      @transactions ||= create_transactions_api
    end

    # @param [String] header
    # @param [String] body
    # @param [Hash] options
    # @return [Hash{Symbol->String | TrueClass | FalseClass}]
    def validate_callback(header, body, options = {})
      create_validate_callback.validate(header, body, options)
    end

    private

    def ensure_config_set!
      unless @config.configured?
        raise Monri::Config::InvalidConfiguration, 'Configuration is not set! Did you call .merchant_key=merchant_key, .authenticity_token=authenticity_token, .environment=environment'
      end
    end

    def http_client
      if defined?(@http_client) && @http_client != nil
        return @http_client
      end
      @http_client = Monri::HttpClient.new
      @http_client.config = @config
      @http_client
    end

    # @return [Monri::ValidateCallback]
    def create_validate_callback
      if @validate_callback_action != nil
        return @validate_callback_action
      end
      ensure_config_set!
      @validate_callback_action = Monri::ValidateCallback.new
      @validate_callback_action.config = @config
      @validate_callback_action
    end

    def create_tokens_api
      ensure_config_set!
      rv = Monri::Tokens.new
      rv.config = @config
      rv.http_client = http_client
      rv
    end

    def create_transactions_api
      ensure_config_set!
      rv = Monri::Transactions.new
      rv.config = @config
      rv.http_client = http_client
      rv
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
