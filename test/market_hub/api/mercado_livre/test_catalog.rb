# frozen_string_literal: true

require "test_helper"

class MarketHub::API::MercadoLivre::TestCatalog < Minitest::Test

  def setup
    @catalog = MarketHub::API::MercadoLivre::Catalog.new(@@meli_access_token)
  end

  def test_if_all_returns_a_catalog_product_list
    site_id = 'MLB'
    q = 'Painel Solar 155w Monocristalino Resun Solar - Rs6e-155m'
    domain_id = 'MLB-SOLAR_PANELS'
    json = @catalog.all(site_id, q, domain_id)

    refute_nil(json)
    assert_equal(json['keywords'], q)
    assert_equal(json['domain_id'], domain_id)
    assert_equal(json['results'].length, 1)
  end

  def test_if_find_returns_catalog_product_detail
    catalog_product_id = 'MLB23546296'
    json = @catalog.find(catalog_product_id)

    refute_nil(json)
    assert_equal(json['id'], catalog_product_id)
    assert_equal(json['domain_id'], 'MLB-SOLAR_PANELS')
    assert_equal(json['name'], 'Painel Solar 155w Monocristalino Resun Solar - Rs6e-155m')
  end

  def test_if_optin_return_catalog_fail
    item_id = @@meli_item_id
    catalog_product_id = 'MLB23546296'
    json = @catalog.optin(item_id, catalog_product_id)

    refute_nil(json)
    assert_equal(json['error'], 'validation_error')
    assert_equal(json['status'], 400)
    assert_equal(json['cause'].first['code'], 'catalog_product_id.invalid')
    assert_equal(json['cause'].first['message'], 'Invalid catalog_product_id: MLB23546296 does not belong to domain MLB-UNCLASSIFIED_PRODUCTS')
  end

end
