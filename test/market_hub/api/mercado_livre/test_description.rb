# frozen_string_literal: true

require "test_helper"

class MarketHub::API::MercadoLivre::TestDescription < Minitest::Test

  def setup
    @description = MarketHub::API::MercadoLivre::Description.new(@@meli_access_token)
  end

  def test_if_find_returns_description_detail
    item_id = 'MLB4386441778'
    json = @description.find(item_id)

    refute_nil(json)
    assert_equal(json['plain_text'].class, String)
    assert_equal(json['plain_text'], 'Lorem ipsum, dolor sit amet consectetur adipisicing elit. Natus fugiat ab, necessitatibus perferendis cupiditate, incidunt omnis distinctio accusamus doloribus quis aut, optio inventore cum facere sed. Consectetur tempora quia eligendi?')
  end
  
  def test_if_create_returns_success
    item_id = 'MLB4386441778'
    description = 'DESCRIÇÃO DE TESTE! POR FAVOR, IGNORE ESSE TEXTO!'
    json = @description.create(item_id, description)

    refute_nil(json)
    assert_equal(json['status'], 400)
    assert_equal(json['error'], 'item.description.invalid')
    assert_equal(json['message'], 'Item already has a description, use PUT instead')
  end

  def test_if_update_returns_success
    item_id = 'MLB4386441778'
    description = 'Lorem ipsum, dolor sit amet consectetur adipisicing elit. Natus fugiat ab, necessitatibus perferendis cupiditate, incidunt omnis distinctio accusamus doloribus quis aut, optio inventore cum facere sed. Consectetur tempora quia eligendi?'
    json = @description.update(item_id, description)

    refute_nil(json)
    assert_equal(json['plain_text'], description)
  end

end
