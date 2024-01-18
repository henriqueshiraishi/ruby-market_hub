# frozen_string_literal: true

require "test_helper"

class MarketHub::API::MercadoLivre::TestPublicationType < Minitest::Test

  def setup
    @access_token = 'APP_USR-7241495617113935-011819-634f068f854445be13c7ccd3eed8d290-1632856741'
    @publication_type = MarketHub::API::MercadoLivre::PublicationType.new(@access_token)
  end

  def test_if_listing_types_returns_listing_types_list
    site_id = 'MLB'
    json = @publication_type.listing_types(site_id)

    refute_nil(json)
    assert_equal(json.class, Array)
    assert_equal(json.length, 7)
    assert_equal(json.first['id'], 'gold_pro')
    assert_equal(json.first['name'], 'Premium')
  end

  def test_if_listing_types_returns_listing_type_with_detail
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

  def test_if_listing_types_availables_returns_listing_types_by_user_and_category
    user_id = '1632856741'
    category_id = 'MLB5672'
    json = @publication_type.listing_types_availables(user_id, category_id)

    refute_nil(json)
    assert_equal(json['available'].length, 7)
    assert_equal(json['category_id'], 'MLB5672')
  end

  def test_if_listing_types_availables_returns_listing_types_by_item
    item_id = 'MLB2665998037'
    json = @publication_type.listing_types_availables(item_id)

    refute_nil(json)
    assert_equal(json['status'], 403)
    assert_equal(json['error'], 'invalid_user')
    assert_equal(json['message'], 'You must be the owner of the item with id MLB2665998037')
  end

  def test_if_listing_types_downgrades_returns_listing_types_by_item
    item_id = 'MLB2665998037'
    json = @publication_type.listing_types_downgrades(item_id)

    refute_nil(json)
    assert_equal(json['status'], 403)
    assert_equal(json['error'], 'invalid_user')
    assert_equal(json['message'], 'You must be the owner of the item with id MLB2665998037')
  end

  def test_if_listing_types_upgrades_returns_listing_types_by_item
    item_id = 'MLB2665998037'
    json = @publication_type.listing_types_upgrades(item_id)

    refute_nil(json)
    assert_equal(json['status'], 403)
    assert_equal(json['error'], 'invalid_user')
    assert_equal(json['message'], 'You must be the owner of the item with id MLB2665998037')
  end

  def test_if_update_returns_a_invalid_user
    item_id = 'MLB2665998037'
    listing_type_id = 'gold_pro'
    json = @publication_type.update(item_id, listing_type_id)

    refute_nil(json)
    assert_equal(json['status'], 403)
    assert_equal(json['error'], 'forbidden')
    assert_equal(json['message'], 'The caller is not authorized to access this resource')
  end

end
