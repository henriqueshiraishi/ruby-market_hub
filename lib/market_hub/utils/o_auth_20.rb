# frozen_string_literal: true

module MarketHub
  module Utils
    # Classe para autorização utilizando método OAuth 2.0
    class OAuth20

      attr_accessor :client_id
      attr_accessor :client_secret

      def initialize(client_id, client_secret)
        @client_id = client_id
        @client_secret = client_secret
      end

      def authorize_url(site, redirect_uri, state = nil)
        endpoint = URI::HTTPS.build(host: site, path: '/authorization')
        endpoint.query = ["response_type=code", "client_id=#{@client_id}", "redirect_uri=#{redirect_uri}"].join('&')
        endpoint.query = [endpoint.query, "state=#{state}"].join('&') unless state.nil?
        endpoint.to_s
      end

      def get_token(site, redirect_uri, code)
        endpoint = URI::HTTPS.build(host: site, path: '/oauth/token')
        body = { grant_type: 'authorization_code', client_id: @client_id, client_secret: @client_secret, code: code, redirect_uri: redirect_uri }
        response = Net::HTTP.post_form(endpoint, body)
        JSON.parse(response.body)
      end

      def renew_token(site, refresh_token)
        endpoint = URI::HTTPS.build(host: site, path: '/oauth/token')
        body = { grant_type: 'refresh_token', client_id: @client_id, client_secret: @client_secret, refresh_token: refresh_token }
        response = Net::HTTP.post_form(endpoint, body)
        JSON.parse(response.body)
      end
  
    end
  end
end
