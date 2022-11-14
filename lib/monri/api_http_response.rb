module Monri
  class ApiHttpResponse

    attr_reader :body
    attr_reader :code
    attr_reader :headers
    attr_reader :exception

    # @param [Net::HTTPResponse] response
    # @return [Monri::ApiHttpResponse]
    def from_net(response)
      @body = begin
        JSON.parse(response.body, symbolize_names: true)
      rescue
        nil
      end
      @code = response.code.to_i
      @headers = response.each_header.to_h
      self
    end
  end
end