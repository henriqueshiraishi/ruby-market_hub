# frozen_string_literal: true

module MarketHub
  module API
    module MercadoLivre
      # Classe API de Descrição de Produto
      class Description

        attr_accessor :access_token
  
        def initialize(access_token)
          @access_token = access_token
        end

        def find(item_id)
          host = MarketHub.configure.meli_api_uri
          path = "/items/#{item_id}/description"
          endpoint = URI::HTTPS.build(host: host, path: path)
          response = MarketHub::HTTP.get(endpoint, headers: { authorization: "Bearer #{@access_token}" })
          JSON.parse(response.body)
        end

        def create(item_id, description)
          host = MarketHub.configure.meli_api_uri
          path = "/items/#{item_id}/description"
          body = { plain_text: description }
          endpoint = URI::HTTPS.build(host: host, path: path)
          response = MarketHub::HTTP.post(endpoint, headers: { authorization: "Bearer #{@access_token}" }, body: body)
          JSON.parse(response.body)
        end

        def update(item_id, description)
          host = MarketHub.configure.meli_api_uri
          path = "/items/#{item_id}/description"
          body = { plain_text: description }
          endpoint = URI::HTTPS.build(host: host, path: path)
          response = MarketHub::HTTP.put(endpoint, headers: { authorization: "Bearer #{@access_token}" }, body: body)
          JSON.parse(response.body)
        end

      end
    end
  end
end
