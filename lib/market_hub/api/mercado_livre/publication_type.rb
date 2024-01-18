# frozen_string_literal: true

module MarketHub
  module API
    module MercadoLivre
      # Classe API de Tipos de Publicação
      class PublicationType

        attr_accessor :access_token

        def initialize(access_token)
          @access_token = access_token
        end

        def listing_types(site_id, listing_type_id = nil)
          host = MarketHub.configure.meli_api_uri
          path = "/sites/#{site_id}/listing_types/"
          path = path + listing_type_id.to_s unless listing_type_id.nil?

          endpoint = URI::HTTPS.build(host: host, path: path)
          response = Net::HTTP.get_response(endpoint)
          JSON.parse(response.body)
        end

        def listing_exposures(site_id,listing_exposure_id = nil)
          host = MarketHub.configure.meli_api_uri
          path = "/sites/#{site_id}/listing_exposures/"
          path = path + listing_exposure_id.to_s unless listing_exposure_id.nil?

          endpoint = URI::HTTPS.build(host: host, path: path)
          response = Net::HTTP.get_response(endpoint)
          JSON.parse(response.body)
        end

        def listing_types_availables(reference_id, category_id = nil)
          host = MarketHub.configure.meli_api_uri
          params = {}

          if category_id.nil?
            path = "/items/#{reference_id}/available_listing_types"
          else
            path = "/users/#{reference_id}/available_listing_types"
            params = params.merge({ category_id: category_id })
          end

          endpoint = URI::HTTPS.build(host: host, path: path)
          endpoint.query = URI.encode_www_form(params)

          request = Net::HTTP::Get.new(endpoint)
          request['Authorization'] = "Bearer #{@access_token}"
          response = Net::HTTP.start(endpoint.host, endpoint.port, use_ssl: true) { |http| http.request(request) }
          JSON.parse(response.body)
        end

        def listing_types_downgrades(item_id)
          host = MarketHub.configure.meli_api_uri
          path = "/items/#{item_id}/available_upgrades"

          endpoint = URI::HTTPS.build(host: host, path: path)
          request = Net::HTTP::Get.new(endpoint)
          request['Authorization'] = "Bearer #{@access_token}"
          response = Net::HTTP.start(endpoint.host, endpoint.port, use_ssl: true) { |http| http.request(request) }
          JSON.parse(response.body)
        end

        def listing_types_upgrades(item_id)
          host = MarketHub.configure.meli_api_uri
          path = "/items/#{item_id}/available_downgrades"

          endpoint = URI::HTTPS.build(host: host, path: path)
          request = Net::HTTP::Get.new(endpoint)
          request['Authorization'] = "Bearer #{@access_token}"
          response = Net::HTTP.start(endpoint.host, endpoint.port, use_ssl: true) { |http| http.request(request) }
          JSON.parse(response.body)
        end

        def update(item_id, listing_type_id)
          host = MarketHub.configure.meli_api_uri
          path = "/items/#{item_id}/listing_type"

          endpoint = URI::HTTPS.build(host: host, path: path)
          request = Net::HTTP::Post.new(endpoint)
          request['Authorization'] = "Bearer #{@access_token}"
          response = Net::HTTP.start(endpoint.host, endpoint.port, use_ssl: true) { |http| http.request(request) }
          JSON.parse(response.body)
        end

      end
    end
  end
end
