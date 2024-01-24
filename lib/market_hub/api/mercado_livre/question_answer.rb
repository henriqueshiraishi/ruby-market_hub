# frozen_string_literal: true

module MarketHub
  module API
    module MercadoLivre
      # Classe API de Perguntas e Respostas
      class QuestionAnswer

        attr_accessor :access_token
        attr_accessor :user_id
  
        def initialize(access_token, user_id)
          @access_token = access_token
          @user_id = user_id
        end

        def metrics
          host = MarketHub.configure.meli_api_uri
          path = "/users/#{@user_id}/questions/response_time"
          endpoint = URI::HTTPS.build(host: host, path: path)
          response = MarketHub::HTTP.get(endpoint, headers: { authorization: "Bearer #{@access_token}" })
          JSON.parse(response.body)
        end

        def all(options = {})
          host = MarketHub.configure.meli_api_uri
          path = "/questions/search"
          params = { seller_id: @user_id, api_version: 4 }.merge(options)
          endpoint = URI::HTTPS.build(host: host, path: path)
          endpoint.query = URI.encode_www_form(params)
          response = MarketHub::HTTP.get(endpoint, headers: { authorization: "Bearer #{@access_token}" })
          JSON.parse(response.body)
        end

        def find(question_id)
          host = MarketHub.configure.meli_api_uri
          path = "/questions/#{question_id}"
          endpoint = URI::HTTPS.build(host: host, path: path)
          endpoint.query = URI.encode_www_form({ api_version: 4 })
          response = MarketHub::HTTP.get(endpoint, headers: { authorization: "Bearer #{@access_token}" })
          JSON.parse(response.body)
        end

        def anwser(question_id, text)
          host = MarketHub.configure.meli_api_uri
          path = "/answers"
          body = { question_id: question_id, text: text }
          endpoint = URI::HTTPS.build(host: host, path: path)
          response = MarketHub::HTTP.post(endpoint, headers: { authorization: "Bearer #{@access_token}" }, body: body)
          JSON.parse(response.body)
        end

        def destroy(question_id)
          host = MarketHub.configure.meli_api_uri
          path = "/questions/#{question_id}"
          endpoint = URI::HTTPS.build(host: host, path: path)
          response = MarketHub::HTTP.delete(endpoint, headers: { authorization: "Bearer #{@access_token}" })
          JSON.parse(response.body)
        end

      end
    end
  end
end
