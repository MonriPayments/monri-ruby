# frozen_string_literal: true

require 'net/http'
require 'uri'
require 'cgi'
require 'json'
require 'forwardable'
require 'digest'
require 'securerandom'
require 'monri/config'
require 'monri/api_client'
require 'monri/api_http_response'
require 'monri/transaction'


module Monri
  @config = Monri::Config.default_config

  class << self
    extend Forwardable
    attr_reader :config

    # @return [String]
    def merchant_key
      @config.merchant_key
    end

    # @return [String]
    def authenticity_token
      @config.authenticity_token
    end

    # @return [String]
    def environment
      @config.environment
    end

    # @return [String]
    def api_key
      @config.api_key
    end

    # @return [String]
    def api_account
      @config.api_account
    end

    # @param [String] val
    # @return [String]
    def merchant_key=(val)
      @config.merchant_key = val
    end

    # @param [String] val
    # @return [String]
    def authenticity_token=(val)
      @config.authenticity_token = val
    end

    # @param [String] val
    # @return [String]
    def environment=(val)
      @config.environment = val
    end

    # @param [String] val
    # @return [String]
    def api_key=(val)
      @config.api_key = val
    end

    # @param [String] val
    # @return [String]
    def api_account=(val)
      @config.api_account = val
    end
  end
end
