# frozen_string_literal: true

module MarketHub
  # Classe base para parametrização da biblioteca
  class Configuration

    attr_accessor :currency_id

    attr_accessor :meli_client_id
    attr_accessor :meli_client_secret
    attr_accessor :meli_redirect_uri
    attr_accessor :meli_auth_uri
    attr_accessor :meli_api_uri

    def initialize
      @meli_client_id = nil
      @meli_client_secret = nil
      @meli_redirect_uri = nil
      @meli_auth_uri = 'auth.mercadolivre.com.br'
      @meli_api_uri = 'api.mercadolibre.com'
      @currency_id = 'BRL'
    end

    def self.default
      @default ||= Configuration.new
    end

  end
end
