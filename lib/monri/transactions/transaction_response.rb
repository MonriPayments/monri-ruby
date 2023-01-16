module Monri
  class Transactions
    class TransactionResponse < Response

      # @param [Hash] params
      def initialize(params)
        if params.has_key?(:errors)
          self[:errors] = params.delete(:errors)
        end

        if params.has_key?(:transaction)
          self[:transaction] = Monri::Transactions::Transaction.new(params.delete(:transaction))
        end

        if params.has_key?(:secure_message)
          self[:secure_message] = Monri::Transactions::SecureMessage.new(params.delete(:secure_message))
        end
        super(params)
      end

      # @return [TrueClass, FalseClass]
      def failed?
        errors != nil && errors.length > 0 || super
      end

      # @return [Array]
      def errors
        self[:errors]
      end

      # @return [Monri::Transactions::TransactionResponse]
      def transaction
        self[:transaction]
      end

      # @return [Monri::Transactions::SecureMessage]
      def secure_message
        self[:secure_message]
      end

      # @return [TransactionResponse]
      def self.create
        raise ArgumentError, 'Provide a block' unless block_given?

        begin
          TransactionResponse.new(yield)
        rescue StandardError => e
          params = { exception: e }
          if e.is_a?(Monri::Errors::HttpRequestError) && e.body != nil
            body = JSON.parse(e.body, symbolize_names: true) rescue {}
            params.merge!(body)
          end
          TransactionResponse.new(params)
        end
      end
    end

  end
end