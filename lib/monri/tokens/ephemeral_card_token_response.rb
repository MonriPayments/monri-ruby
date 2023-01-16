module Monri
  class Tokens
    class EphemeralCardTokenResponse < Response

      def approved?
        status == 'approved'
      end

      # @return [String]
      def id
        self[:id]
      end

      # @return [String]
      def status
        self[:status]
      end

      # @return [String]
      def masked_pan
        self[:masked_pan]
      end

      # @return [String]
      def cc_type
        self[:cc_type]
      end

      # @return [String]
      def cc_issuer
        self[:cc_issuer]
      end

      # @return [EphemeralCardTokenResponse]
      def self.create
        raise ArgumentError, 'Provide a block' unless block_given?

        begin
          EphemeralCardTokenResponse.new(yield)
        rescue StandardError => e
          EphemeralCardTokenResponse.new(exception: e)
        end
      end
    end
  end
end