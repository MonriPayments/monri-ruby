module Monri
  class ApiHttpResponse

    attr_reader :body
    attr_reader :response_body
    attr_reader :code
    attr_reader :headers
    attr_reader :exception

    # @param [Net::HTTPResponse] response
    # @return [Monri::ApiHttpResponse]
    def from_net(response)

      @code = response.code.to_i
      @headers = response.each_header.to_h
      @response_body = response.body
      @body = begin
        JSON.parse(response.body, symbolize_names: true)
      rescue
        @exception = create_exception('JSON parsing failed')
        nil
      end
      unless success?
        @exception = create_exception("Request failed, got status code=#{code}")
      end
      self
    end

    def success?
      code >= 200 && code < 300
    end

    private

    # @param [String] message
    def create_exception(message)
      Monri::Errors::HttpRequestError.new(message, code: @code, body: @response_body, headers: @headers)
    end

  end
end