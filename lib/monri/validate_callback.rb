module Monri
  class ValidateCallback

    # @return [Monri::Config]
    attr_accessor :config

    # @param [String] header
    # @param [String] body
    # @param [Hash] options
    # @return [Hash{Symbol->String | TrueClass | FalseClass}]
    def validate(header, body, options = {})

      unless header.is_a?(String)
        raise Monri::Errors::InvalidArgumentsError.new('First parameter - authorization header, should be a String')
      end

      unless body.is_a?(String)
        raise Monri::Errors::InvalidArgumentsError.new('Second parameter - body, should be a String')
      end

      unless options.is_a?(Hash)
        raise Monri::Errors::InvalidArgumentsError.new('Third parameter - options, should be a Hash')
      end

      version = options.delete(:version) || '2'

      if version == 'v2'
        expected_digest = Digest::SHA512.hexdigest("#{config.merchant_key}#{body}")
      elsif version == '1'
        unless options.has_key?(:order_number)
          raise Monri::Errors::InvalidArgumentsError.new('For version=1 provide order-number')
        end
        order_number = options.delete(:order_number)
        expected_digest = Digest::SHA1.hexdigest("#{config.merchant_key}#{order_number}")
      else
        raise Monri::Errors::InvalidArgumentsError.new("Version option, value='#{version}' is not supported")
      end

      expected_header = "WP3-callback #{expected_digest}"
      {
        header: header,
        expected_header: expected_header,
        valid: header == expected_header
      }
    end
  end
end