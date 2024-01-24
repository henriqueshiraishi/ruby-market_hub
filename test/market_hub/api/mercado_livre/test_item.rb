# frozen_string_literal: true

require "test_helper"

class MarketHub::API::MercadoLivre::TestItem < Minitest::Test

  def setup
    @item = MarketHub::API::MercadoLivre::Item.new(@@meli_access_token, @@meli_user_id)
  end

  def test_if_all_returns_search_results
    json = @item.all

    refute_nil(json)
    assert_equal(json['seller_id'], @@meli_user_id)
    assert_equal(json['results'].class, Array)
  end

  def test_if_find_returns_all_fields
    item_id = 'MLB2665998037'
    json = @item.find(item_id)

    refute_nil(json)
    assert_equal(json['id'], 'MLB2665998037')
    assert_equal(json['title'], 'Tomada 4x2 20a Bivolt Tramontina C/ Parafusos')
    assert_equal(json['site_id'], 'MLB')
    assert_equal(json['category_id'], 'MLB269930')
    assert_equal(json['listing_type_id'], 'gold_special')
    assert_equal(json['catalog_product_id'], 'MLB22663864')
    assert_equal(json['domain_id'], 'MLB-ELECTRICAL_OUTLETS')
  end

  def test_if_find_by_sku_returns_a_array_list
    seller_sku = '1234567-MINITEST'
    json = @item.find_by_sku(seller_sku)

    refute_nil(json)
    assert_equal(json.class, Array)
    assert_equal(json.first['id'], @@meli_item_id)
  end

  def test_if_create_returns_success
    body = {
      title: "Item de Teste - Por favor, NÃO OFERTAR!",
      category_id: "MLB3530",
      price: 350,
      currency_id: "BRL",
      available_quantity: 1,
      buying_mode: "buy_it_now",
      condition: "new",
      listing_type_id: "free",
      sale_terms: [
        { id: "WARRANTY_TYPE", value_name: "Garantia do vendedor" },
        { id: "WARRANTY_TIME", value_name: "90 dias" },
        { id: "MANUFACTURING_TIME", value_name: "20 dias" }
     ],
      pictures: [
        { source: "http://mla-s2-p.mlstatic.com/968521-MLA20805195516_072016-O.jpg" }
      ],
      attributes: [
        { id: "SELLER_SKU", value_name: "1234567" },
        { id: "GTIN", value_name: "7898945080293" },
        { id: "BRAND", value_name: "Genérica" },
        { id: "MODEL", value_name: "Genérica" }
      ],
      channels: ["marketplace"]
    }

    json = @item.create(body)

    refute_nil(json)
  end

  def test_if_update_returns_success
    item_id = @@meli_item_id
    body = {
      price: 192,
      available_quantity: 1,
      channels: ["marketplace", "mshops"]
    }

    json = @item.update(item_id, body)

    refute_nil(json)
    assert_equal(json['id'], @@meli_item_id)
    assert_equal(json['price'], 192)
    assert_equal(json['available_quantity'], 1)
    assert_equal(json['channels'], ["marketplace", "mshops"])
  end

  def test_if_destroy_return_success
    item_id = 'MLB4386378812'
    json = @item.destroy(item_id)

    refute_nil(json)
    assert_equal(json['id'], 'MLB4386378812')
  end

end
