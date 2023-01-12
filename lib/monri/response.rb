# frozen_string_literal: true

module Monri
  class Response < Hash

    def initialize(params = {})
      if params.has_key?(:exception)
        self[:exception] = params[:exception]
      end
      self.merge!(params)
    end

    # @return [Exception, NilClass]
    def exception
      self[:exception]
    end

    # @param [Exception] val
    def exception=(val)
      self[:exception] = val
    end

    def failed?
      exception != nil
    end

    # @param [Exception] exception
    def self.exception(exception)
      rv = Response.new
      rv.exception = exception
      rv
    end
  end
end
