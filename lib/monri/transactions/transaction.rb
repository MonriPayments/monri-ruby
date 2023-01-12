module Monri
  class Transactions
    class Transaction < Hash

      # @param [Hash] params
      def initialize(params)
        self.merge!(params)
      end

      # @return [String]
      def id
        self[:id]
      end

      # @return [String]
      def acquirer
        self[:acquirer]
      end

      # @return [String]
      def order_number
        self[:order_number]
      end

      # @return [String]
      def amount
        self[:amount]
      end

      # @return [String]
      def currency
        self[:currency]
      end

      # @return [String]
      def outgoing_amount
        self[:outgoing_amount]
      end

      # @return [String]
      def outgoing_currency
        self[:outgoing_currency]
      end

      # @return [String]
      def approval_code
        self[:approval_code]
      end

      # @return [String]
      def response_code
        self[:response_code]
      end

      # @return [String]
      def response_message
        self[:response_message]
      end

      # @return [String]
      def reference_number
        self[:reference_number]
      end

      # @return [String]
      def systan
        self[:systan]
      end

      # @return [String]
      def eci
        self[:eci]
      end

      # @return [String]
      def xid
        self[:xid]
      end

      # @return [String]
      def acsv
        self[:acsv]
      end

      # @return [String]
      def cc_type
        self[:cc_type]
      end

      # @return [String]
      def status
        self[:status]
      end

      # @return [String]
      def created_at
        self[:created_at]
      end

      # @return [String]
      def transaction_type
        self[:transaction_type]
      end

      # @return [String]
      def enrollment
        self[:enrollment]
      end

      # @return [String]
      def authentication
        self[:authentication]
      end

      # @return [String]
      def pan_token
        self[:pan_token]
      end

      # @return [String]
      def issuer
        self[:issuer]
      end

      # @return [String]
      def three_ds_version
        self[:three_ds_version]
      end
    end
  end
end