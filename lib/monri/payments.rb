# frozen_string_literal: true

module Monri
  class Payments
    # @return [Monri::Config]
    attr_accessor :config
    # @return [Monri::HttpClient]
    attr_writer :http_client

    # @return [Monri::AccessTokens]
    attr_writer :access_tokens

    # @param [Hash] options
    # @return [Monri::Payments::CreateResponse]
    def create(options)
      CreateResponse.create do
        access_token = @access_tokens.create!(scopes: ['payments']).access_token
        response = @http_client.post('/v2/payment/new', options, oauth: access_token)
        if response.failed?
          raise response.exception
        elsif response.success?
          response.body
        else
          nil
        end
      end
    end

    # @param [String] id
    # @return [StatusResponse] id
    def status(id)
      StatusResponse.create do
        if id.nil? || !id.is_a?(String)
          raise ArgumentError('Id should be a string')
        end

        access_token = @access_tokens.create!(scopes: ['payments']).access_token
        response = @http_client.get("/v2/payment/#{id}/status", oauth: access_token)
        if response.failed?
          raise response.exception
        elsif response.success?
          response.body
        else
          # TODO: handle this case
        end
      end
    end
  end
end
