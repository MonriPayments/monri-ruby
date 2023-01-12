module Monri
  class AccessTokens
    class CreateResponse < Response

      # @return [String]
      def access_token
        self[:access_token]
      end

      # @return [String]
      def status
        self[:status]
      end

      # @return [String]
      def token_type
        self[:token_type]
      end

      # @return [String]
      def expires_in
        self[:expires_in]
      end

      # @return [CreateResponse]
      def self.create
        raise ArgumentError, 'Provide a block' unless block_given?

        begin
          CreateResponse.new(yield)
        rescue StandardError => e
          CreateResponse.new(exception: e)
        end
      end
    end
  end
end