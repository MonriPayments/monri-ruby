module Monri
  class Config
    attr_accessor :merchant_key
    attr_accessor :authenticity_token
    attr_accessor :environment

    alias api_key merchant_key
    alias api_key= merchant_key=
    alias api_account authenticity_token
    alias api_account= authenticity_token=

    # @return [String]
    def base_api_url
      if environment == :test
        'https://ipgtest.monri.com'
      elsif environment == :production
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
  end
end