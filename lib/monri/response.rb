# frozen_string_literal: true

module Monri
  class Response
    # @return [Object]
    attr_accessor :result
    # @return [Exception]
    attr_accessor :exception

    # @return [Monri::Response]
    # @param [Object] result
    def self.result(result)
      raise ArgumentError, 'Argument result is nil' if result.nil?

      rv = Response.new
      rv.result = result
      rv
    end

    def success?
      exception == nil
    end

    def failed?
      exception != nil
    end

    def self.create
      raise ArgumentError, 'Provide a block' unless block_given?

      begin
        result(yield)
      rescue StandardError => e
        exception(e)
      end
    end

    # @param [Exception] exception
    def self.exception(exception)
      rv = Response.new
      rv.exception = exception
      rv
    end
  end
end
