# frozen_string_literal: true

require "test_helper"

class MarketHub::API::MercadoLivre::TestAuthorization < Minitest::Test

  def setup
    @client_id = '7241495617113935'
    @client_secret = '1b8JzDc6NPlUKOZimybInVM0BZ5QHDl1'
    @redirect_uri = 'https://app.exemple.com/oauth/redirect'

    @oauth20 = MarketHub::API::MercadoLivre::Authorization.new(@client_id, @client_secret, @redirect_uri)
  end

  def test_if_authorize_url_returns_a_valid_url
    state = 'ML-3484YHBWE84983W7Y42'
    valid_url = @oauth20.authorize_url(state)

    assert_equal(valid_url, 'https://auth.mercadolivre.com.br/authorization?response_type=code&client_id=7241495617113935&redirect_uri=https://app.exemple.com/oauth/redirect&state=ML-3484YHBWE84983W7Y42')
  end

  def test_if_get_token_returns_a_error
    code = 'TG-65a03df7ac1a050001c3503a-1303777413'
    json = @oauth20.get_token(code)

    assert_equal(json['message'], 'Error validating grant. Your authorization code or refresh token may be expired or it was already used')
    assert_equal(json['error'], 'invalid_grant')
    assert_equal(json['status'], 400)
  end

  def test_if_renew_token_returns_a_error
    refresh_token = 'TG-65a03df7ac1a050001c3503a-1303777413'
    json = @oauth20.renew_token(refresh_token)

    assert_equal(json['message'], 'Error validating grant. Your authorization code or refresh token may be expired or it was already used')
    assert_equal(json['error'], 'invalid_grant')
    assert_equal(json['status'], 400)
  end

end
