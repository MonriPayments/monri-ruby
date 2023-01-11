module Monri
  module Transaction

    # @param [Hash] params
    # @param [Hash] options
    # @return [Monri::ApiHttpResponse]
    def self.create(params = {})
      params[:digest] = Digest::SHA512.hexdigest([Monri.api_key, params[:order_number], params[:amount], params[:currency]].join)
      params[:authenticity_token] = Monri.api_account
      Client.post('/v2/transaction', { transaction: params })
    end

  end
end