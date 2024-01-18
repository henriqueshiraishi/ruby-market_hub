# frozen_string_literal: true

module MarketHub
  module API
    module MercadoLivre
      # Classe API de Tipos de Publicação
      class PublicationType

        def initialize
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

      end
    end
  end
end
