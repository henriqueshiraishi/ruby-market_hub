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

    def self.post_form(uri, headers: {}, body: {}, files: nil)
      request = Net::HTTP::Post.new(uri)
      type = :form_data
      MarketHub::HTTP.execute(uri, request, headers, body, type, files)
    end

    def self.put(uri, headers: {}, body: {})
      request = Net::HTTP::Put.new(uri)
      MarketHub::HTTP.execute(uri, request, headers, body)
    end

    def self.put_form(uri, headers: {}, body: {}, files: nil)
      request = Net::HTTP::Put.new(uri)
      type = :form_data
      MarketHub::HTTP.execute(uri, request, headers, body, type, files)
    end

    def self.delete(uri, headers: {})
      request = Net::HTTP::Delete.new(uri)
      MarketHub::HTTP.execute(uri, request, headers)
    end

    def self.execute(uri, request, headers = nil, body = nil, type = :raw_data, files = nil)
      Net::HTTP.start(uri.hostname, uri.port, use_ssl: uri.scheme == 'https') do |http|
        case type
        when :raw_data
          request.body = body.to_json if body
        when :form_data
          request.form_data = body if body
          request.set_form(files.map { |file| ['file', file, { filename: File.basename(file) }] }, 'multipart/form-data') if files
        end

        headers.each { |header, value| request[header] = value } if headers
        http.request(request)
      end
    end

  end
end
