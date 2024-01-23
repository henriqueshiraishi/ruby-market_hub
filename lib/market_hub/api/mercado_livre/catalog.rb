# frozen_string_literal: true

module MarketHub
  module API
    module MercadoLivre
      # Classe API de Catálogo
      class Catalog

        attr_accessor :access_token
  
        def initialize(access_token)
          @access_token = access_token
        end

        def all(site_id, q, domain_id = nil, status = 'active', options = {})
          host = MarketHub.configure.meli_api_uri
          path = "/products/search"
          params = { site_id: site_id, q: q }.merge(options)
          params.merge!({ domain_id: domain_id }) if domain_id
          params.merge!({ status: status }) if status

          endpoint = URI::HTTPS.build(host: host, path: path)
          endpoint.query = URI.encode_www_form(params)

          response = MarketHub::HTTP.get(endpoint, headers: { authorization: "Bearer #{@access_token}" })
          JSON.parse(response.body)
        end

        def find(catalog_product_id)
          host = MarketHub.configure.meli_api_uri
          path = "/products/#{catalog_product_id}"

          endpoint = URI::HTTPS.build(host: host, path: path)
          response = MarketHub::HTTP.get(endpoint, headers: { authorization: "Bearer #{@access_token}" })
          JSON.parse(response.body)
        end

        def optin(item_id, catalog_product_id, variation_id = nil)
          host = MarketHub.configure.meli_api_uri
          path = "/items/catalog_listings"

          body = { item_id: item_id, catalog_product_id: catalog_product_id }
          body[:variation_id] = variation_id if variation_id

          endpoint = URI::HTTPS.build(host: host, path: path)
          response = MarketHub::HTTP.post(endpoint, headers: { authorization: "Bearer #{@access_token}" }, body: body)
          JSON.parse(response.body)
        end

      end
    end
  end
end
