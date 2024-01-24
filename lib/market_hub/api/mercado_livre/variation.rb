# frozen_string_literal: true

module MarketHub
  module API
    module MercadoLivre
      # Classe API de Variação
      class Variation

        attr_accessor :access_token
        attr_accessor :item_id
  
        def initialize(access_token, item_id)
          @access_token = access_token
          @item_id = item_id
        end

        def all(params = {})
          host = MarketHub.configure.meli_api_uri
          path = "/items/#{@item_id}/variations/"
          if params[:variation_id]
            path = path + params[:variation_id]
            params.delete(:variation_id)
          end
          endpoint = URI::HTTPS.build(host: host, path: path)
          endpoint.query = URI.encode_www_form(params)
          response = MarketHub::HTTP.get(endpoint, headers: { authorization: "Bearer #{@access_token}" })
          JSON.parse(response.body)
        end

        def find(variation_id)
          all({ variation_id: variation_id })
        end

        def create(body)
          host = MarketHub.configure.meli_api_uri
          path = "/items/#{@item_id}/variations"
          endpoint = URI::HTTPS.build(host: host, path: path)
          response = MarketHub::HTTP.post(endpoint, headers: { authorization: "Bearer #{@access_token}" }, body: body)
          JSON.parse(response.body)
        end

        def update(variation_id, body)
          host = MarketHub.configure.meli_api_uri
          path = "/items/#{@item_id}/variations/#{variation_id}"
          endpoint = URI::HTTPS.build(host: host, path: path)
          response = MarketHub::HTTP.put(endpoint, headers: { authorization: "Bearer #{@access_token}" }, body: body)
          JSON.parse(response.body)
        end

        def destroy(variation_id)
          host = MarketHub.configure.meli_api_uri
          path = "/items/#{@item_id}/variations/#{variation_id}"
          endpoint = URI::HTTPS.build(host: host, path: path)
          response = MarketHub::HTTP.delete(endpoint, headers: { authorization: "Bearer #{@access_token}" })
          JSON.parse(response.body)
        end

      end
    end
  end
end
