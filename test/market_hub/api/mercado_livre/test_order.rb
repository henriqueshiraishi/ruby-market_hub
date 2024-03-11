# frozen_string_literal: true

require "test_helper"

class MarketHub::API::MercadoLivre::TestOrder < Minitest::Test

  def setup
    @order = MarketHub::API::MercadoLivre::Order.new(@@meli_access_token, @@meli_user_id)
  end

  def test_if_all_returns_a_order_list
    json = @order.all(status: 'paid', options: { tags: 'paid', q: 'Item De Teste - Por Favor, Não Ofertar!' })

    refute_nil(json)
    assert_equal(json['results'].class, Array)
    assert_equal(json['filters'].length, 2)
    assert_equal(json['query'], 'Item De Teste - Por Favor, Não Ofertar!')
  end

  def test_if_recent_returns_a_order_list
    json = @order.recent(status: 'paid', options: { tags: 'paid', q: 'Item De Teste - Por Favor, Não Ofertar!' })

    refute_nil(json)
    assert_equal(json['results'].class, Array)
    assert_equal(json['filters'].length, 2)
    assert_equal(json['query'], 'Item De Teste - Por Favor, Não Ofertar!')
  end

  def test_if_find_return_a_valid_order
    json = @order.find(@@meli_order_id)

    refute_nil(json)
    assert_equal(json['id'], @@meli_order_id.to_i)
    assert_equal(json['total_amount'], 576.0)
    assert_equal(json['payments'].first['marketplace_fee'], 97.92)
    assert_equal(json['order_items'].length, 1)
    assert_equal(json['status'], 'paid')
  end

  def test_if_notes_return_a_notes_list_from_order
    json = @order.notes(@@meli_order_id)

    refute_nil(json)
    assert_equal(json.class, Array)
    assert_equal(json.first['order_id'], @@meli_order_id.to_i)
    assert_equal(json.first['results'].class, Array)
    assert_equal(json.first['results'].first['note'], "COMENTÁRIO DE TESTE COMENTÁRIO DE TESTE")
  end

  def test_if_billing_info_return_a_address_from_order
    json = @order.billing_info(@@meli_order_id)

    refute_nil(json)
    assert_equal(json['billing_info']['doc_type'], "CPF")
    assert_equal(json['billing_info']['doc_number'], "22434506070")
    assert_equal(json['billing_info']['additional_info'].class, Array)
  end

end
