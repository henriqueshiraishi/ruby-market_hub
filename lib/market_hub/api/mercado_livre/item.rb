# frozen_string_literal: true

module MarketHub
  module API
    module MercadoLivre
      # Classe API de Produtos
      class Item

        attr_accessor :access_token
        attr_accessor :user_id
  
        def initialize(access_token, user_id)
          @access_token = access_token
          @user_id = user_id
        end

        def all(params = {})
          host = MarketHub.configure.meli_api_uri
          path = "/users/#{@user_id}/items/search"

          endpoint = URI::HTTPS.build(host: host, path: path)
          endpoint.query = URI.encode_www_form(params)

          response = MarketHub::HTTP.get(endpoint, headers: { authorization: "Bearer #{@access_token}" })
          JSON.parse(response.body)
        end

        def find(item_id)
          host = MarketHub.configure.meli_api_uri
          path = "/items/#{item_id}"

          endpoint = URI::HTTPS.build(host: host, path: path)
          response = MarketHub::HTTP.get(endpoint, headers: { authorization: "Bearer #{@access_token}" })
          JSON.parse(response.body)
        end

        def find_by_sku(seller_sku)
          item_ids = all({ seller_sku: seller_sku }).dig('results')
          item_ids.map { |item_id| find(item_id) } if item_ids
        end

        def create(body)
          host = MarketHub.configure.meli_api_uri
          path = '/items'

          endpoint = URI::HTTPS.build(host: host, path: path)
          response = MarketHub::HTTP.post(endpoint, headers: { authorization: "Bearer #{@access_token}" }, body: body)
          JSON.parse(response.body)
        end

        def update(item_id, body)
          host = MarketHub.configure.meli_api_uri
          path = "/items/#{item_id}"

          endpoint = URI::HTTPS.build(host: host, path: path)
          response = MarketHub::HTTP.put(endpoint, headers: { authorization: "Bearer #{@access_token}" }, body: body)
          JSON.parse(response.body)
        end

        def destroy(item_id)
          update(item_id, { status: "closed" })
          update(item_id, { deleted: true })
        end
  
      end
    end
  end
end
