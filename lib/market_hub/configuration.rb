# frozen_string_literal: true

module MarketHub
  # Classe base para parametrização da biblioteca
  class Configuration

    attr_accessor :client_id
    attr_accessor :client_secret
    attr_accessor :redirect_uri
    attr_accessor :meli_auth_uri
    attr_accessor :meli_api_uri

    def initialize
      @client_id = nil
      @client_secret = nil
      @redirect_uri = nil
      @meli_auth_uri = 'auth.mercadolivre.com.br'
      @meli_api_uri = 'api.mercadolibre.com'
    end

    def self.default
      @default ||= Configuration.new
    end

  end
end
