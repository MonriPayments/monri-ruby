module Monri
  class Transactions
    class TransactionResponse < Response

      # @param [Hash] params
      def initialize(params)
        if params.has_key?(:transaction)
          self[:transaction] = Monri::Transactions::Transaction.new(params.delete(:transaction))
        end

        if params.has_key?(:secure_message)
          self[:secure_message] = Monri::Transactions::SecureMessage.new(params.delete(:secure_message))
        end
        super(params)
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
          TransactionResponse.new(exception: e)
        end
      end
    end

  end
end