module Monri
  class Payments
    class CreateResponse < Response

      def approved?
        status == 'approved'
      end

      # @return [String]
      def status
        self[:status]
      end

      # @return [String]
      def id
        self[:id]
      end

      # @return [String]
      def client_secret
        self[:client_secret]
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