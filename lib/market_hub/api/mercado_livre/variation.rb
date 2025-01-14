# frozen_string_literal: true

module MarketHub
  module API
    module MercadoLivre
      # Classe API de Variação
      class Variation

        attr_accessor :access_token
  
        def initialize(access_token)
          @access_token = access_token
        end

        def all(item_id, params = {})
          host = MarketHub.configure.meli_api_uri
          path = "/items/#{item_id}/variations/"
          if params[:variation_id]
            path = path + params[:variation_id]
            params.delete(:variation_id)
          end
          endpoint = URI::HTTPS.build(host: host, path: path)
          endpoint.query = URI.encode_www_form(params)
          response = MarketHub::HTTP.get(endpoint, headers: { authorization: "Bearer #{@access_token}" })
          JSON.parse(response.body)
        end

        def find(item_id, variation_id)
          all(item_id, { variation_id: variation_id })
        end

        def create(item_id, body)
          host = MarketHub.configure.meli_api_uri
          path = "/items/#{item_id}/variations"
          endpoint = URI::HTTPS.build(host: host, path: path)
          response = MarketHub::HTTP.post(endpoint, headers: { authorization: "Bearer #{@access_token}" }, body: body)
          JSON.parse(response.body)
        end

        def update(item_id, variation_id, body)
          host = MarketHub.configure.meli_api_uri
          path = "/items/#{item_id}/variations/#{variation_id}"
          endpoint = URI::HTTPS.build(host: host, path: path)
          response = MarketHub::HTTP.put(endpoint, headers: { authorization: "Bearer #{@access_token}" }, body: body)
          JSON.parse(response.body)
        end

        def destroy(item_id, variation_id)
          host = MarketHub.configure.meli_api_uri
          path = "/items/#{item_id}/variations/#{variation_id}"
          endpoint = URI::HTTPS.build(host: host, path: path)
          response = MarketHub::HTTP.delete(endpoint, headers: { authorization: "Bearer #{@access_token}" })
          JSON.parse(response.body)
        end

      end
    end
  end
end
