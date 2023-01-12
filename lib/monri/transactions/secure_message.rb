module Monri
  class Transactions
    class SecureMessage < Hash
      # @param [Hash] params
      def initialize(params)
        self.merge!(params)
      end

      # @return [String]
      def id
        self[:id]
      end

      # @return [String]
      def acs_url
        self[:acs_url]
      end

      # @return [String]
      def pareq
        self[:pareq]
      end

      # @return [String]
      def authenticity_token
        self[:authenticity_token]
      end
    end
  end
end