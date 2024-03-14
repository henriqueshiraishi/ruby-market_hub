# frozen_string_literal: true

require "test_helper"

class MarketHub::API::MercadoLivre::TestVariation < Minitest::Test

  def setup
    @variation = MarketHub::API::MercadoLivre::Variation.new(@@meli_access_token)
    @item_id = 'MLB2089509261'
  end

  def test_if_all_returns_a_variation_list_from_item
    json = @variation.all(@item_id)

    refute_nil(json)
    assert_equal(json.length, 5)
  end

  def test_if_find_returns_detail_about_variation
    variation_id = '173922290996'
    json = @variation.find(@item_id, variation_id)

    refute_nil(json)
    assert_equal(json['id'].to_s, variation_id)
    assert_equal(json['attribute_combinations'].class, Array)
  end

  def test_if_create_variation_returns_forbidden
    body = {
      attribute_combinations: [
        { id: "COLOR", value_name: "Preto" },
        { id: "SIZE", value_name: "M" }
      ],
      price: 99999,
      available_quantity: 10,
      picture_ids: [ "836334-MLB74037091612_012024" ],
      catalog_product_id: "MLB23546296",
      attributes: [
        { id: "GTIN", value_name: "7892642360580" },
        { id: "SELLER_SKU", value_name: "1234567-1" }
      ]
    }
    json = @variation.create(@item_id, body)

    refute_nil(json)
    assert_equal(json['status'], 403)
    assert_equal(json['error'], 'forbidden')
    assert_equal(json['message'], 'The caller is not authorized to access this resource')
  end

  def test_if_update_variation_returns_forbidden
    variation_id = '173922290996'
    body = { price: 200 }
    json = @variation.update(@item_id, variation_id, body)

    refute_nil(json)
    assert_equal(json['status'], 403)
    assert_equal(json['error'], 'forbidden')
    assert_equal(json['message'], 'The caller is not authorized to access this resource')
  end

  def test_if_destroy_variation_returns_forbidden
    variation_id = '173922290996'
    json = @variation.destroy(@item_id, variation_id)

    refute_nil(json)
    assert_equal(json['status'], 403)
    assert_equal(json['error'], 'forbidden')
    assert_equal(json['message'], 'The caller is not authorized to access this resource')
  end

end
