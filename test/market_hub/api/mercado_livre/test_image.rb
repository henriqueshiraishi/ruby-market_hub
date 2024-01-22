# frozen_string_literal: true

require "test_helper"

class MarketHub::API::MercadoLivre::TestImage < Minitest::Test

  def setup
    @image = MarketHub::API::MercadoLivre::Image.new(@@meli_access_token)
  end

  def test_if_upload_returns_success
    file = File.open('test/fixtures/photo_61774546050b7.jpg')
    json = @image.upload(file)

    refute_nil(json)
    refute_nil(json['id'])
    refute_nil(json['hash'])
    assert_equal(json['max_size'], '1085x1047')
    assert_equal(json['variations'].length, 17)
  end

  def test_if_add_new_image_in_publication
    item_id = @@meli_item_id
    image_id = '900849-MLB74047943292_012024'
    json = @image.add(item_id, image_id)

    refute_nil(json)
    assert_equal(json['error'], 'validation_error')
    assert_equal(json['status'], 400)
    assert_equal(json['cause'].first['code'], 'item.pictures.alreadyInItem')
  end

  def test_if_change_image_in_publication
    item_id = @@meli_item_id
    images = ['836334-MLB74037091612_012024', '900849-MLB74047943292_012024']
    json = @image.change(item_id, images)

    refute_nil(json)
    assert_equal(json['id'], item_id)
    assert_equal(json['seller_id'].to_s, @@meli_user_id)
  end

end
