# frozen_string_literal: true

module MarketHub
  module API
    module MercadoLivre
      # Classe API de Categoria
      class Category

        def initialize
        end

        def predict(site_id, q, options = {})
          host = MarketHub.configure.meli_api_uri
          path = "/sites/#{site_id}/domain_discovery/search"
          params = { q: q }.merge(options)

          endpoint = URI::HTTPS.build(host: host, path: path)
          endpoint.query = URI.encode_www_form(params)

          response = MarketHub::HTTP.get(endpoint)
          JSON.parse(response.body)
        end

        def site(site_id)
          host = MarketHub.configure.meli_api_uri
          path = "/sites/#{site_id}/categories"

          endpoint = URI::HTTPS.build(host: host, path: path)
          response = MarketHub::HTTP.get(endpoint)
          JSON.parse(response.body)
        end

        def detail(category_id)
          host = MarketHub.configure.meli_api_uri
          path = "/categories/#{category_id}"

          endpoint = URI::HTTPS.build(host: host, path: path)
          response = MarketHub::HTTP.get(endpoint)
          JSON.parse(response.body)
        end

        def attributes(category_id)
          host = MarketHub.configure.meli_api_uri
          path = "/categories/#{category_id}/attributes"

          endpoint = URI::HTTPS.build(host: host, path: path)
          response = MarketHub::HTTP.get(endpoint)
          JSON.parse(response.body)
        end
  
      end
    end
  end
end
