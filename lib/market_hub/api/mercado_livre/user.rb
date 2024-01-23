# frozen_string_literal: true

module MarketHub
  module API
    module MercadoLivre
      # Classe API do Usuário
      class User

        attr_accessor :access_token
  
        def initialize(access_token)
          @access_token = access_token
        end

        def me
          host = MarketHub.configure.meli_api_uri
          path = "/users/me"

          endpoint = URI::HTTPS.build(host: host, path: path)
          response = MarketHub::HTTP.get(endpoint, headers: { authorization: "Bearer #{@access_token}" })
          JSON.parse(response.body)
        end

        def currency
          host = MarketHub.configure.meli_api_uri
          path = "/classified_locations/countries/#{me['country_id']}"

          endpoint = URI::HTTPS.build(host: host, path: path)
          response = MarketHub::HTTP.get(endpoint, headers: { authorization: "Bearer #{@access_token}" })
          JSON.parse(response.body)
        end

      end
    end
  end
end
