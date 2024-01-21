# frozen_string_literal: true

module MarketHub
  # Classe para autorização utilizando método OAuth 2.0
  class OAuth20

    attr_accessor :client_id
    attr_accessor :client_secret
    attr_accessor :redirect_uri

    def initialize(client_id, client_secret, redirect_uri)
      @client_id = client_id
      @client_secret = client_secret
      @redirect_uri = redirect_uri
    end

    def authorize_url(site, path, state = nil)
      endpoint = URI::HTTPS.build(host: site, path: path)
      endpoint.query = ["response_type=code", "client_id=#{@client_id}", "redirect_uri=#{@redirect_uri}"].join('&')
      endpoint.query = [endpoint.query, "state=#{state}"].join('&') unless state.nil?
      endpoint.to_s
    end

    def get_token(site, path, code)
      endpoint = URI::HTTPS.build(host: site, path: path)
      body = {  grant_type: 'authorization_code', client_id: @client_id,
                client_secret: @client_secret, code: code, redirect_uri: @redirect_uri }
      response = MarketHub::HTTP.post_form(endpoint, body: body)
      JSON.parse(response.body)
    end

    def renew_token(site, path, refresh_token)
      endpoint = URI::HTTPS.build(host: site, path: path)
      body = {  grant_type: 'refresh_token', client_id: @client_id,
                client_secret: @client_secret, refresh_token: refresh_token }
      response = MarketHub::HTTP.post_form(endpoint, body: body)
      JSON.parse(response.body)
    end

  end
end
