# frozen_string_literal: true

module MarketHub
  module API
    module MercadoLivre
      # Classe API de Categoria
      class Category

        def initialize
        end

        def predict_category(site_id, q, options = {})
          host = MarketHub.configure.meli_api_uri
          path = "/sites/#{site_id}/domain_discovery/search"
          params = { q: q }.merge(options)

          endpoint = URI::HTTPS.build(host: host, path: path)
          endpoint.query = URI.encode_www_form(params)

          response = Net::HTTP.get_response(endpoint)
          JSON.parse(response.body)
        end
  
      end
    end
  end
end
