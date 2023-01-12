module Monri
  class Customers
    class CreateResponse < Response

      # @return [String]
      def uuid
        self[:uuid]
      end

      # @return [String]
      def merchant_customer_id
        self[:merchant_customer_id]
      end

      # @return [String]
      def description
        self[:description]
      end

      # @return [String]
      def email
        self[:email]
      end

      # @return [String]
      def name
        self[:name]
      end

      # @return [String]
      def phone
        self[:phone]
      end

      # @return [String]
      def status
        self[:status]
      end

      # @return [String]
      def deleted
        self[:deleted]
      end

      # @return [String]
      def city
        self[:city]
      end

      # @return [String]
      def country
        self[:country]
      end

      # @return [String]
      def zip_code
        self[:zip_code]
      end

      # @return [String]
      def address
        self[:address]
      end

      # @return [String]
      def metadata
        self[:metadata]
      end

      # @return [String]
      def created_at
        self[:created_at]
      end

      # @return [String]
      def updated_at
        self[:updated_at]
      end

      # @return [String]
      def deleted_at
        self[:deleted_at]
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