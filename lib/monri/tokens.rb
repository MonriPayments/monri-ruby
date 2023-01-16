module Monri
  class Tokens

    # @return [Monri::Config]
    attr_accessor :config

    # @return [Monri::HttpClient]
    attr_accessor :http_client

    TEMP_TOKENIZE_REQUIRED_FIELDS = [:cvv, :type, :pan, :expiration_date, :temp_card_id, :digest, :timestamp]

    # @note Create ephemeral (lasting for a very short time - 15minutes in this case) - token to replace card details.
    # Required fields are: pan, expiration_date(YYMM), cvv, type (card). Optional fields are: tokenize_pan: bool
    # @param [Hash] params
    def create_ephemeral_card_token(params)

      EphemeralCardTokenResponse.create do
        ensure_configured!

        # If there's no temp-card-id, create one
        unless params.has_key?(:temp_card_id)
          params.merge!(create_card_token)
        end

        missing_keys = TEMP_TOKENIZE_REQUIRED_FIELDS.reject { |k| params.has_key?(k) }

        params[:authenticity_token] = config.authenticity_token

        if missing_keys.length > 0
          raise Monri::Errors::InvalidArgumentsError.new("Missing required keys=#{missing_keys.join(', ')}")
        end

        #  TODO: assert if merchant has PCI-DSS certificate - request pci-dss access token
        http_response = http_client.post('/v2/temp-tokenize', params)
        if http_response.failed?
          raise http_response.exception
        elsif http_response.success?
          http_response.body
        else
          #  TODO: handle this case
        end
      end
    end

    private

    def ensure_configured!
      if config == nil || http_client == nil
        raise Monri::Errors::InvalidArgumentsError.new('Configuration error, config or http client not set')
      end
    end

    # @param [Hash] params
    # @return [Hash]
    def create_card_token(params = {})
      ensure_configured!

      token = params.has_key?(:temp_card_id) ? params.delete(:temp_card_id) : SecureRandom.hex
      timestamp = Time.now.iso8601
      {
        timestamp: timestamp,
        temp_card_id: token,
        digest: Digest::SHA512.hexdigest("#{config.merchant_key}#{token}#{timestamp}")
      }
    end

  end
end