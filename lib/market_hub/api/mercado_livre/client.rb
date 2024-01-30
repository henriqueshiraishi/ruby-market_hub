# frozen_string_literal: true

module MarketHub
  module API
    module MercadoLivre
      # Principal classe para integração com Mercado Livre
      class Client < MarketHub::API::Base

        attr_reader :user
        attr_reader :me
        attr_reader :currency
        attr_reader :catalog
        attr_reader :category
        attr_reader :description
        attr_reader :image
        attr_reader :invoice
        attr_reader :item
        attr_reader :order
        attr_reader :publication_type
        attr_reader :question_answer
        attr_reader :shipment
  
        def initialize(access_token)
          @user = MarketHub::API::MercadoLivre::User.new(access_token)
          @me = @user.me

          if connected?
            @currency = @user.currency['currency_id']
            @catalog = MarketHub::API::MercadoLivre::Catalog.new(access_token)
            @category = MarketHub::API::MercadoLivre::Category.new
            @description = MarketHub::API::MercadoLivre::Description.new(access_token)
            @image = MarketHub::API::MercadoLivre::Image.new(access_token)
            @invoice = MarketHub::API::MercadoLivre::Invoice.new(access_token, @me['site_id'])
            @item = MarketHub::API::MercadoLivre::Item.new(access_token, @me['id'])
            @order = MarketHub::API::MercadoLivre::Order.new(access_token, @me['id'])
            @publication_type = MarketHub::API::MercadoLivre::PublicationType.new(access_token)
            @question_answer = MarketHub::API::MercadoLivre::QuestionAnswer.new(access_token, @me['id'])
            @shipment = MarketHub::API::MercadoLivre::Shipment.new(access_token)
          end
        end

        def connected?
          @me['id'] ? true : false
        end

        def find(id)
          @item.find(id) if connected?
        end

        def quantity(id, available_quantity)
          @item.update(id, { available_quantity: available_quantity })
        end
  
      end
    end
  end
end
