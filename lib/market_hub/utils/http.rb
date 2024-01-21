# frozen_string_literal: true

module MarketHub
  # Módulo que simplifica as requisições HTTP/HTTPS
  module HTTP

    def self.get(uri, headers: {})
      request = Net::HTTP::Get.new(uri)
      MarketHub::HTTP.execute(uri, request, headers)
    end

    def self.post(uri, headers: {}, body: {})
      request = Net::HTTP::Post.new(uri)
      MarketHub::HTTP.execute(uri, request, headers, body)
    end

    def self.post_form(uri, headers: {}, body: {})
      request = Net::HTTP::Post.new(uri)
      MarketHub::HTTP.execute(uri, request, headers, body, :form_data)
    end

    def self.put(uri, headers: {}, body: {})
      request = Net::HTTP::Put.new(uri)
      MarketHub::HTTP.execute(uri, request, headers, body)
    end

    def self.execute(uri, request, headers, body = nil, type = :raw_data)
      Net::HTTP.start(uri.hostname, uri.port, use_ssl: uri.scheme == 'https') do |http|
        if body
          case type
          when :raw_data
            request.body = body.to_json
          when :form_data
            request.form_data = body
          end
        end

        headers.each { |header, value| request[header] = value } if headers
        http.request(request)
      end
    end

  end
end
