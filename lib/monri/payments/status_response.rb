module Monri
  class Payments
    class StatusResponse < Response

      # @param [Hash] params
      def initialize(params)
        if params.has_key?(:payment_result)
          self[:payment_result] = PaymentResult.new(params.delete(:payment_result))
        end
        self.merge!(params)
      end

      # @return [String]
      def status
        self[:status]
      end

      # @return [String]
      def payment_status
        self[:payment_status]
      end

      # @return [String]
      def client_secret
        self[:client_secret]
      end

      # @return [Monri::Payments::PaymentResult]
      def payment_result
        self[:payment_result]
      end

      # @return [StatusResponse]
      def self.create
        raise ArgumentError, 'Provide a block' unless block_given?

        begin
          StatusResponse.new(yield)
        rescue StandardError => e
          StatusResponse.new(exception: e)
        end
      end
    end
  end
end