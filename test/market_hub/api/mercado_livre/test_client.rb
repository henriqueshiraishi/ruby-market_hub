# frozen_string_literal: true

require "test_helper"

class MarketHub::API::MercadoLivre::TestClient < Minitest::Test

  def setup
    @client = MarketHub::API::MercadoLivre::Client.new(@@meli_access_token)
  end

  def test_if_the_client_is_connected
    connected = @client.connected?
    assert_equal(connected, true)
  end

  def test_if_the_client_find_some_item
    json = @client.find(@@meli_item_id)
    assert_equal(json['id'], @@meli_item_id)
  end

  def test_if_me_returns_user_data
    user_id = @client.me['id']
    assert_equal(user_id, @@meli_user_id.to_i)
  end

  def test_if_the_client_update_stock
    json = @client.quantity(@@meli_item_id, 1)
    assert_equal(json['id'], @@meli_item_id)
    assert_equal(json['available_quantity'], 1)
  end

end
