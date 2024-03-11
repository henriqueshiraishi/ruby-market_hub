# frozen_string_literal: true

module MarketHub
  module API
    module MercadoLivre
      # Classe API de Pedidos
      class Order

        attr_accessor :access_token
        attr_accessor :user_id

        def initialize(access_token, user_id)
          @access_token = access_token
          @user_id = user_id
        end

        # Principais status existentes: paid, cancelled e invalid
        def all(status: 'paid', options: {})
          host = MarketHub.configure.meli_api_uri
          path = "/orders/search"
          endpoint = URI::HTTPS.build(host: host, path: path)
          params = { seller: @user_id }.merge(options)
          params.merge!({ "order.status" => status }) if status
          endpoint.query = URI.encode_www_form(params)
          response = MarketHub::HTTP.get(endpoint, headers: { authorization: "Bearer #{@access_token}" })
          JSON.parse(response.body)
        end

        # Principais status existentes: paid, cancelled e invalid
        def recent(status: 'paid', options: {})
          host = MarketHub.configure.meli_api_uri
          path = "/orders/search/recent"
          endpoint = URI::HTTPS.build(host: host, path: path)
          params = { seller: @user_id }.merge(options)
          params.merge!({ "order.status" => status }) if status
          endpoint.query = URI.encode_www_form(params)
          response = MarketHub::HTTP.get(endpoint, headers: { authorization: "Bearer #{@access_token}" })
          JSON.parse(response.body)
        end

        def find(order_id)
          host = MarketHub.configure.meli_api_uri
          path = "/orders/#{order_id}"
          endpoint = URI::HTTPS.build(host: host, path: path)
          response = MarketHub::HTTP.get(endpoint, headers: { authorization: "Bearer #{@access_token}" })
          JSON.parse(response.body)
        end

        def notes(order_id)
          host = MarketHub.configure.meli_api_uri
          path = "/orders/#{order_id}/notes"
          endpoint = URI::HTTPS.build(host: host, path: path)
          response = MarketHub::HTTP.get(endpoint, headers: { authorization: "Bearer #{@access_token}" })
          JSON.parse(response.body)
        end

        def billing_info(order_id)
          host = MarketHub.configure.meli_api_uri
          path = "/orders/#{order_id}/billing_info"
          endpoint = URI::HTTPS.build(host: host, path: path)
          response = MarketHub::HTTP.get(endpoint, headers: { authorization: "Bearer #{@access_token}" })
          JSON.parse(response.body)
        end

      end
    end
  end
end
