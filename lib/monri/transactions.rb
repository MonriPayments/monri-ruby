module Monri
  class Transactions

    # @return [Monri::Config]
    attr_writer :config

    # @return [Monri::HttpClient]
    attr_writer :http_client

    REQUIRED_FIELDS = [
      :transaction_type,
      :amount,
      :ip,
      :order_info,
      :ch_address,
      :ch_city,
      :ch_country,
      :ch_email,
      :ch_full_name,
      :ch_phone,
      :ch_zip,
      :currency,
      :order_number,
      :language
    ].freeze

    REQUIRED_TRX_MANAGEMENT_FIELDS = [
      :amount,
      :currency,
      :order_number
    ].freeze

    # @param [Hash] params
    # @return [Monri::Transactions::TransactionResponse]
    def transaction(params)
      TransactionResponse.create do
        unless params.is_a?(Hash)
          raise Monri::Errors::InvalidArgumentsError.new('First parameter - params, should be a Hash')
        end

        missing_keys = REQUIRED_FIELDS.reject { |k| params.has_key?(k) }
        if missing_keys.length > 0
          raise Monri::Errors::InvalidArgumentsError.new("Missing required keys=#{missing_keys.join(', ')}")
        end

        params[:authenticity_token] = @config.authenticity_token
        digest_parts = [@config.merchant_key, params[:order_number], params[:amount], params[:currency]]
        params[:digest] = Digest::SHA512.hexdigest(digest_parts.join)

        req = { transaction: params }

        rv = @http_client.post('/v2/transaction', req)
        if rv.failed?
          raise rv.exception
        elsif rv.success?
          rv.body
        else
          raise "Unhandled state, exception=#{rv.exception}, failed=#{rv.failed?}, success=#{rv.success?}"
        end
      end
    end

    def void(params)
      unless params.is_a?(Hash)
        raise Monri::Errors::InvalidArgumentsError.new('First parameter - params, should be a Hash')
      end
      trx_management(params.merge(transaction_type: 'void'))
    end

    def refund(params)
      unless params.is_a?(Hash)
        raise Monri::Errors::InvalidArgumentsError.new('First parameter - params, should be a Hash')
      end
      trx_management(params.merge(transaction_type: 'refund'))
    end

    def capture(params)
      unless params.is_a?(Hash)
        raise Monri::Errors::InvalidArgumentsError.new('First parameter - params, should be a Hash')
      end
      trx_management(params.merge(transaction_type: 'capture'))
    end

    private

    # @param [Hash] params
    # @return [Monri::Transactions::TransactionResponse]
    def trx_management(params)
      TransactionResponse.create do
        unless params.is_a?(Hash)
          raise Monri::Errors::InvalidArgumentsError.new('First parameter - params, should be a Hash')
        end

        missing_keys = REQUIRED_TRX_MANAGEMENT_FIELDS.reject { |k| params.has_key?(k) }
        if missing_keys.length > 0
          raise Monri::Errors::InvalidArgumentsError.new("Missing required keys=#{missing_keys.join(', ')}")
        end

        params[:authenticity_token] = @config.authenticity_token
        digest_parts = [@config.merchant_key, params[:order_number], params[:amount], params[:currency]]
        params[:digest] = Digest::SHA512.hexdigest(digest_parts.join)

        req = { transaction: params }

        rv = @http_client.post('/v2/trx-management', req)
        if rv.failed?
          raise rv.exception
        elsif rv.success?
          rv.body
        else
          raise "Unhandled state, exception=#{rv.exception}, failed=#{rv.failed?}, success=#{rv.success?}"
        end
      end
    end

  end
end