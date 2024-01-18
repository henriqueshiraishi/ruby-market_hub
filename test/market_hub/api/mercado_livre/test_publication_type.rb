# frozen_string_literal: true

require "test_helper"

class MarketHub::API::MercadoLivre::TestPublicationType < Minitest::Test

  def setup
    @publication_type = MarketHub::API::MercadoLivre::PublicationType.new
  end

  def test_if_listing_types_returns_publication_types_list
    site_id = 'MLB'
    json = @publication_type.listing_types(site_id)

    refute_nil(json)
    assert_equal(json.class, Array)
    assert_equal(json.length, 7)
    assert_equal(json.first['id'], 'gold_pro')
    assert_equal(json.first['name'], 'Premium')
  end

  def test_if_listing_types_returns_publication_type_with_detail
    site_id = 'MLB'
    listing_type_id = 'gold_pro'
    json = @publication_type.listing_types(site_id, listing_type_id)

    refute_nil(json)
    assert_equal(json.class, Hash)
    assert_equal(json['id'], 'gold_pro')
    assert_equal(json['configuration']['name'], 'Premium')
    assert_equal(json['configuration']['listing_exposure'], 'highest')
  end

  def test_if_listing_exposures_retuns_exposure_types_list
    site_id = 'MLB'
    json = @publication_type.listing_exposures(site_id)

    refute_nil(json)
    assert_equal(json.class, Array)
    assert_equal(json.length, 5)
    assert_equal(json.first['id'], 'lowest')
    assert_equal(json.first['name'], 'Última')
  end

  def test_if_listing_exposures_retuns_exposure_type_with_detail
    site_id = 'MLB'
    listing_exposure_id = 'lowest'
    json = @publication_type.listing_exposures(site_id, listing_exposure_id)

    refute_nil(json)
    assert_equal(json.class, Hash)
    assert_equal(json['id'], 'lowest')
    assert_equal(json['name'], 'Última')
    assert_equal(json['home_page'], false)
    assert_equal(json['category_home_page'], false)
  end

end
