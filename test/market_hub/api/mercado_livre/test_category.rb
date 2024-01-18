# frozen_string_literal: true

require "test_helper"

class MarketHub::API::MercadoLivre::TestCategory < Minitest::Test

  def setup
    @meli = MarketHub::API::MercadoLivre::Category.new
  end

  def test_if_predict_category_returns_list_categories
    site_id = 'MLB'
    q = 'ÁGUA'
    options = { limit: 3 }
    json = @meli.predict_category(site_id, q, options)

    refute_nil(json)
    assert_equal(json.class, Array)
    assert_equal(json.length, 3)
    assert_equal(json.first['domain_id'], 'MLB-READY_TO_DRINK_COCKTAILS')
    assert_equal(json.first['domain_name'], 'Bebidas alcoólicas prontas para beber')
    assert_equal(json.first['category_id'], 'MLB277634')
    assert_equal(json.first['category_name'], 'Bebidas Alcoólicas Mistas')
  end

end
