module Monri
  module Errors
    class HttpRequestError < StandardError

      # @return [Integer]
      attr_reader :code
      # @return [String, NilClass]
      attr_reader :body

      # @return [Hash]
      attr_reader :headers

      # @param [String] message
      # @param [Hash] options
      def initialize(message, options)
        super(message)
        @code = options.delete(:code) || 500
        @body = options.delete(:body)
        @headers = options.delete(:headers)
      end
    end
  end
end