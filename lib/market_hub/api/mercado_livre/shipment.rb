# frozen_string_literal: true

module MarketHub
  module API
    module MercadoLivre
      # Classe API de Transporte
      class Shipment

        attr_accessor :access_token
        attr_reader :types

        def initialize(access_token)
          @access_token = access_token
          @types = %w(items costs payments lead_time delays history carrier billing_info)
        end

        def find(shipment_id, type = nil)
          host = MarketHub.configure.meli_api_uri
          path = "/shipments/#{shipment_id}/"
          path = path + type.to_s unless type.nil?
          endpoint = URI::HTTPS.build(host: host, path: path)
          response = MarketHub::HTTP.get(endpoint, headers: { authorization: "Bearer #{@access_token}" })
          JSON.parse(response.body)
        end

        def labels(shipment_ids, response_type = 'pdf')
          shipment_ids = shipment_ids.join(',') if shipment_ids.is_a?(Array)
          host = MarketHub.configure.meli_api_uri
          path = "/shipment_labels"
          params = { shipment_ids: shipment_ids, response_type: response_type }
          endpoint = URI::HTTPS.build(host: host, path: path)
          endpoint.query = URI.encode_www_form(params)
          response = MarketHub::HTTP.get(endpoint, headers: { authorization: "Bearer #{@access_token}" })
          try_to_convert_to_json(response.body)
        end

        private

          def try_to_convert_to_json(body)
            JSON.parse(body)
          rescue
            body
          end

      end
    end
  end
end
