# frozen_string_literal: true

require "test_helper"

class MarketHub::Utils::TestOAuth20 < Minitest::Test

  def setup
    @client_id = '7241495617113935'
    @client_secret = '1b8JzDc6NPlUKOZimybInVM0BZ5QHDl1'
    @redirect_uri = 'https://app.exemple.com/oauth/redirect'

    @oauth20 = MarketHub::Utils::OAuth20.new(@client_id, @client_secret, @redirect_uri)
  end

  def test_if_authorize_url_returns_a_valid_url
    site = 'auth.mercadolivre.com.br'
    path = '/authorization'
    state = 'ML-3484YHBWE84983W7Y42'
    valid_url = @oauth20.authorize_url(site, path, state)

    assert_equal(valid_url, 'https://auth.mercadolivre.com.br/authorization?response_type=code&client_id=7241495617113935&redirect_uri=https://app.exemple.com/oauth/redirect&state=ML-3484YHBWE84983W7Y42')
  end

  def test_if_get_token_returns_a_error
    site = MarketHub.configure.meli_api_uri
    path = '/oauth/token'
    code = 'TG-65a03df7ac1a050001c3503a-1303777413'
    json = @oauth20.get_token(site, path, code)

    assert_equal(json['message'], 'Error validating grant. Your authorization code or refresh token may be expired or it was already used')
    assert_equal(json['error'], 'invalid_grant')
    assert_equal(json['status'], 400)
  end

  def test_if_renew_token_returns_a_error
    site = MarketHub.configure.meli_api_uri
    path = '/oauth/token'
    refresh_token = 'TG-65a03df7ac1a050001c3503a-1303777413'
    json = @oauth20.renew_token(site, path, refresh_token)

    assert_equal(json['message'], 'Error validating grant. Your authorization code or refresh token may be expired or it was already used')
    assert_equal(json['error'], 'invalid_grant')
    assert_equal(json['status'], 400)
  end

end
