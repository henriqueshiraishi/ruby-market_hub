# frozen_string_literal: true

require "test_helper"

class MarketHub::TestHTTP < Minitest::Test

  def setup
    @item_id = 'MLB2665998037'
    @access_token = 'APP_USR-7241495617113935-011819-634f068f854445be13c7ccd3eed8d290-1632856741'
  end

  def test_if_post_with_all_arguments_works
    host = MarketHub.configure.meli_api_uri
    path = "/items/#{@item_id}/listing_type"

    endpoint = URI::HTTPS.build(host: host, path: path)
    headers = { authorization: "Bearer #{@access_token}" }
    body = { id: 'gold_special' }
    response = MarketHub::HTTP.post(endpoint, headers: headers, body: body)
    json = JSON.parse(response.body)

    refute_nil(json)
    assert_equal(json['status'], 403)
    assert_equal(json['error'], 'forbidden')
    assert_equal(json['message'], 'The caller is not authorized to access this resource')
  end

  def test_if_get_with_all_arguments_works
    host = MarketHub.configure.meli_api_uri
    path = "/items/#{@item_id}/available_listing_types"

    endpoint = URI::HTTPS.build(host: host, path: path)
    headers = { Authorization: "Bearer #{@access_token}" }
    response = MarketHub::HTTP.get(endpoint, headers: headers)
    json = JSON.parse(response.body)

    refute_nil(json)
    assert_equal(json['status'], 403)
    assert_equal(json['error'], 'invalid_user')
    assert_equal(json['message'], 'You must be the owner of the item with id MLB2665998037')
  end

end
