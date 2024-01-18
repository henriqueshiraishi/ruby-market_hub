# frozen_string_literal: true

require "test_helper"

class MarketHub::API::MercadoLivre::TestCategory < Minitest::Test

  def setup
    @category = MarketHub::API::MercadoLivre::Category.new
  end

  def test_if_predict_returns_a_categories_list
    site_id = 'MLB'
    q = 'ÁGUA'
    options = { limit: 3 }
    json = @category.predict(site_id, q, options)

    refute_nil(json)
    assert_equal(json.class, Array)
    assert_equal(json.length, 3)
    assert_equal(json.first['domain_id'], 'MLB-READY_TO_DRINK_COCKTAILS')
    assert_equal(json.first['domain_name'], 'Bebidas alcoólicas prontas para beber')
    assert_equal(json.first['category_id'], 'MLB277634')
    assert_equal(json.first['category_name'], 'Bebidas Alcoólicas Mistas')
  end

  def test_if_site_returns_a_categories_list
    site_id = 'MLB'
    json = @category.site(site_id)

    refute_nil(json)
    assert_equal(json.class, Array)
    assert_equal(json.length, 32)
    assert_equal(json.first['id'], 'MLB5672')
    assert_equal(json.first['name'], 'Acessórios para Veículos')
  end

  def test_if_detail_returns_category_detail
    category_id = 'MLB5672'
    json = @category.detail(category_id)

    refute_nil(json)
    assert_equal(json.class, Hash)
    assert_equal(json['id'], 'MLB5672')
    assert_equal(json['name'], 'Acessórios para Veículos')
    assert_equal(json['date_created'], '2018-04-25T08:12:56.000Z')
  end

  def test_if_attributes_returns_category_attributes
    category_id = 'MLB5672'
    json = @category.attributes(category_id)

    refute_nil(json)
    assert_equal(json.class, Array)
    assert_equal(json.length, 26)
    assert_equal(json.first['id'], 'BRAND')
    assert_equal(json.first['name'], 'Marca')
    assert_equal(json.first['value_type'], 'string')
    assert_equal(json.first['value_max_length'], 255)
    assert_equal(json.first['hint'], "Informe a marca verdadeira do produto ou 'Genérica' se não tiver marca.")
  end

end
