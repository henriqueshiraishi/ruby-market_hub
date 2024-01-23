# frozen_string_literal: true

require "test_helper"

class MarketHub::API::MercadoLivre::TestUser < Minitest::Test

  def setup
    @user = MarketHub::API::MercadoLivre::User.new(@@meli_access_token)
  end

  def test_if_user_me_returns_info_about_account
    json = @user.me

    refute_nil(json)
    assert_equal(json['id'].to_s, @@meli_user_id)
    assert_equal(json['country_id'], "BR")
  end

  def test_if_currency_returns_info_about_money
    json = @user.currency

    refute_nil(json)
    assert_equal(json['id'], "BR")
    assert_equal(json['name'], "Brasil")
    assert_equal(json['currency_id'], "BRL")
  end

end
