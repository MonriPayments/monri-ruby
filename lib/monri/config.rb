# frozen_string_literal: true

module Monri
  class Config
    attr_accessor :merchant_key
    attr_accessor :authenticity_token

    SUPPORTED_ENVS = %w[test production].freeze

    # @return [String]
    def base_api_url
      if environment == 'test'
        'https://ipgtest.monri.com'
      elsif environment == 'production'
        'https://ipg.monri.com'
      else
        raise ArgumentError, "Environment=#{environment} not supported"
      end
    end

    def self.default_config
      rv = Config.new
      rv.environment = :test
      rv
    end

    attr_reader :environment

    def environment=(val)
      val = val.nil? ? nil : val.to_s
      unless SUPPORTED_ENVS.include?(val)
        raise Monri::Config::InvalidConfiguration, "Environment='#{val}' is not supported environment"
      end

      @environment = val
    end

    def configured?
      !merchant_key.nil? && !authenticity_token.nil? && !environment.nil?
    end

    class InvalidConfiguration < StandardError; end
  end
end
