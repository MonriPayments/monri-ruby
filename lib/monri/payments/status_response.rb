module Monri
  class Payments
    class StatusResponse < Response
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