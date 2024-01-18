# frozen_string_literal: true

module MarketHub
  # Módulo que simplifica as requisições HTTP/HTTPS
  module HTTP

    def self.get(uri, headers: {})
      Net::HTTP.start(uri.hostname, uri.port, use_ssl: uri.scheme == 'https') do |http|
        request = Net::HTTP::Get.new(uri)
        headers.each { |header, value| request[header] = value } if headers
        http.request(request)
      end
    end

    def self.post(uri, headers: {}, body: {})
      Net::HTTP.start(uri.hostname, uri.port, use_ssl: uri.scheme == 'https') do |http|
        request = Net::HTTP::Post.new(uri)
        request.form_data = body
        headers.each { |header, value| request[header] = value } if headers
        http.request(request)
      end
    end

  end
end
