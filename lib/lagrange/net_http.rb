require 'net/http'

module Net
  class HTTP

    def request_with_interpolate(request, body = nil, &block)
      response = request_without_interpolate(request, body)
      if point = Lagrange.point
        point.http_request = request
        point.http_response = response
      end

      yield response if block_given?
      response
    end

    alias request_without_interpolate request
    alias request request_with_interpolate
  end

end
