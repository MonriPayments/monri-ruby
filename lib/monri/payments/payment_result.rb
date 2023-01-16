module Monri
  class Payments
    class PaymentResult < Hash

      # @param [Hash] params
      def initialize(params)
        merge!(params)
      end

      # @return [String]
      def currency
        self[:currency]
      end

      # @return [String]
      def amount
        self[:amount]
      end

      # @return [String]
      def order_number
        self[:order_number]
      end

      # @return [String]
      def created_at
        self[:created_at]
      end

      # @return [String]
      def status
        self[:status]
      end

      # @return [String]
      def transaction_type
        self[:transaction_type]
      end

      # @return [String]
      def payment_method
        self[:payment_method]
      end

      # @return [String]
      def response_message
        self[:response_message]
      end

    end
  end
end