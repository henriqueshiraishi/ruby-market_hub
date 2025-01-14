# frozen_string_literal: true

require "test_helper"

class MarketHub::API::MercadoLivre::TestShipment < Minitest::Test

  def setup
    @shipment = MarketHub::API::MercadoLivre::Shipment.new(@@meli_access_token)
  end

  def test_if_find_return_detail_about_shipment
    json = @shipment.find(@@meli_shipment_id)

    refute_nil(json)
    assert_equal(json['id'], @@meli_shipment_id.to_i)
    assert_equal(json['sender_id'], @@meli_user_id.to_i)
    assert_equal(json['base_cost'], 36.1)
    assert_equal(json['order_cost'], 576)
  end

  def test_if_find_with_type_items_return_about_order_item
    json = @shipment.find(@@meli_shipment_id, 'items')

    refute_nil(json)
    assert_equal(json.class, Array)
    assert_equal(json.length, 1)
    assert_equal(json.first['item_id'], 'MLB4389178328')
    assert_equal(json.first['quantity'], 3)
  end

  def test_if_find_with_type_costs_return_about_shipment_cost
    json = @shipment.find(@@meli_shipment_id, 'costs')

    refute_nil(json)
    assert_equal(json['gross_amount'], 179.8)
    assert_equal(json['receiver']['cost'], 0)
    assert_equal(json['receiver']['save'], 0)
    assert_equal(json['senders'].class, Array)
    assert_equal(json['senders'].first['cost'], 86.22)
    assert_equal(json['senders'].first['save'], 57.48)
  end

  def test_if_labels_return_file_content_to_print
    file = @shipment.labels(@@meli_shipment_id, 'pdf')
    refute_nil(file)
  end

  def test_if_find_with_type_billing_info_return_about_receiver_and_sender
    json = @shipment.find(@@meli_shipment_id, 'billing_info')

    refute_nil(json)
    assert_equal(json['receiver'].class, Hash)
    assert_equal(json['receiver']['id'], 1634844864)
    assert_equal(json['receiver']['document']['id'], 'CPF')
    assert_equal(json['receiver']['document']['value'], '22434506070')
    assert_equal(json['receiver']['city_ibge'], '3550308')
    assert_equal(json['receiver']['name'], 'Test Test')
    assert_equal(json['senders'].class, Array)
    assert_equal(json['senders'].length, 1)
    assert_equal(json['senders'].first['id'], @@meli_user_id.to_i)
    assert_equal(json['senders'].first['document']['id'], 'CPF')
    assert_equal(json['senders'].first['document']['value'], '11111111111')
    assert_equal(json['senders'].first['city_ibge'], '3550308')
    assert_equal(json['senders'].first['name'], 'Test Test')
  end

end
