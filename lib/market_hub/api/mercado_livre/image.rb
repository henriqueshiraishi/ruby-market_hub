# frozen_string_literal: true

module MarketHub
  module API
    module MercadoLivre
      # Classe API de Imagem
      class Image
        
        attr_accessor :access_token

        def initialize(access_token)
          @access_token = access_token
        end

        def upload(file)
          host = MarketHub.configure.meli_api_uri
          path = "/pictures/items/upload"

          endpoint = URI::HTTPS.build(host: host, path: path)
          response = MarketHub::HTTP.post_form(endpoint, headers: { authorization: "Bearer #{@access_token}" }, body: nil, files: [ file ])
          JSON.parse(response.body)
        end

        def add(item_id, image_id)
          host = MarketHub.configure.meli_api_uri
          path = "/items/#{item_id}/pictures"

          endpoint = URI::HTTPS.build(host: host, path: path)
          response = MarketHub::HTTP.post(endpoint, headers: { authorization: "Bearer #{@access_token}" }, body: { id: image_id })
          JSON.parse(response.body)
        end

        def change(item_id, images)
          host = MarketHub.configure.meli_api_uri
          path = "/items/#{item_id}"
          body = { pictures: images.map { |image_id| { id: image_id } } }

          endpoint = URI::HTTPS.build(host: host, path: path)
          response = MarketHub::HTTP.put(endpoint, headers: { authorization: "Bearer #{@access_token}" }, body: body)
          JSON.parse(response.body)
        end

      end
    end
  end
end
