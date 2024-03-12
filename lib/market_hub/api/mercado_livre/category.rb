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

        def find(category_id)
          host = MarketHub.configure.meli_api_uri
          path = "/categories/#{category_id}"
          endpoint = URI::HTTPS.build(host: host, path: path)
          response = MarketHub::HTTP.get(endpoint)
          JSON.parse(response.body)
        end

        def domain(domain_id)
          host = MarketHub.configure.meli_api_uri
          path = "/catalog_domains/#{domain_id}"
          endpoint = URI::HTTPS.build(host: host, path: path)
          response = MarketHub::HTTP.get(endpoint)
          JSON.parse(response.body)
        end

        # Principais tags existentes: required, catalog_required, allow_variations e variation_attribute
        # @category.attributes('MLB40411') => Retorna todos os atributos
        # @category.attributes('MLB40411', { required: true }) => Retorna todos os atributos primários obrigatórios
        # @category.attributes('MLB40411', { allow_variations: true }) => Retorna todos os atributos primários obrigatórios
        # @category.attributes('MLB40411', { variation_attribute: true }) => Retorna todos os atributos secundários de variação
        def attributes(category_id, tags = {})
          host = MarketHub.configure.meli_api_uri
          path = "/categories/#{category_id}/attributes"
          endpoint = URI::HTTPS.build(host: host, path: path)
          response = MarketHub::HTTP.get(endpoint)
          json = JSON.parse(response.body)
          if json.is_a?(Array)
            tags.each do |tag, value|
              json = json.select { |attribute| attribute['tags'][tag.to_s] == value }
            end
          end
          json
        end

        def sale_terms(category_id)
          host = MarketHub.configure.meli_api_uri
          path = "/categories/#{category_id}/sale_terms"
          endpoint = URI::HTTPS.build(host: host, path: path)
          response = MarketHub::HTTP.get(endpoint)
          JSON.parse(response.body)
        end
  
      end
    end
  end
end
