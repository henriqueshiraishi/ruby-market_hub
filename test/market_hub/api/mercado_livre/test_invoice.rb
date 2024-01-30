# frozen_string_literal: true

require "test_helper"

class MarketHub::API::MercadoLivre::TestInvoice < Minitest::Test

  def setup
    @site_id = 'MLB'
    @invoice = MarketHub::API::MercadoLivre::Invoice.new(@@meli_access_token, @site_id)
  end

  def test_if_find_return_invoice_not_found_error
    json = @invoice.find(@@meli_shipment_id)

    refute_nil(json)
    assert_equal(json['status'], 404)
    assert_equal(json['message'], 'Not found shipment invoice with shipmentId: 43054715141')
    assert_equal(json['error'], 'not_found_shipment_invoice')
  end

  def test_if_create_return_invoice_date_error
    invoice_data = File.read('test/fixtures/20240130000559-35231121684155000164550010000023331084193155-nfe.xml')
    json = @invoice.create(@@meli_shipment_id, invoice_data)

    refute_nil(json)
    assert_equal(json['status'], 400)
    assert_equal(json['message'], 'NFe date must be greater than the sale date.')
    assert_equal(json['error'], 'wrong_invoice_date')
  end

  def test_if_update_return_unexpected_error
    invoice_data = File.read('test/fixtures/20240130000559-35231121684155000164550010000023331084193155-nfe.xml')
    json = @invoice.update(@@meli_shipment_id, invoice_data)

    refute_nil(json)
    assert_equal(json['status'], 415)
    assert_equal(json['message'], "Content type 'application/xml;charset=UTF-8' not supported")
    assert_equal(json['error'], 'UNEXPECTED_ERROR')
  end

end
