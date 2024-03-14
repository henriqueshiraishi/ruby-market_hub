# frozen_string_literal: true

module MarketHub
  module Models
    module MercadoLivre
      # Classe que representa uma Variação no Mercado Livre
      class Variation < MarketHub::Models::Base

        attr_accessor :item_id, :variation_id, :attribute_combinations, :price, :available_quantity, :picture_ids, :catalog_product_id, :attributes

        validates_presence_of :item_id, :attribute_combinations, :price, :available_quantity, message: 'não pode estar em branco.'

        def initialize(client, body = {}, options = {})
          super(client, body, options)
          unless body.empty?
            @id = body.dig(:variation_id) || body.dig('id')
            @item_id = body.dig(:item_id) || body.dig('item_id')
            @variation_id = body.dig(:variation_id) || body.dig('id')
            @attribute_combinations = body.dig(:attribute_combinations) || body.dig('attribute_combinations')
            @price = (body.dig(:price) || body.dig('price')).to_f
            @available_quantity = body.dig(:available_quantity) || body.dig('available_quantity')
            @picture_ids = body.dig(:picture_ids) || body.dig('picture_ids')
            @catalog_product_id = body.dig(:catalog_product_id) || body.dig('catalog_product_id')
            @attributes = body.dig(:attributes) || body.dig('attributes')
          end
        end

        def variation_id=(value)
          @id = value
          @variation_id = value
        end

        def save
          if client.connected?
            if valid?
              @was_new = new?
              @was_update = update?

              if new?
                json = client.variation.create(@item_id, new_layout)
              else
                json = client.variation.update(@item_id, @variation_id, update_layout)
              end

              if json['id']
                @id ||= json['id']
                @variation_id ||= json['id']
              elsif json['error']
                errors.add(:item, (json['cause'].to_a.empty? ? json['message'] : json['cause'].to_a.map { |e| e['message'] }.join('. ')))
              else
                errors.add(:item, "Ocorreu um erro ao enviar o item para o marketplace.")
              end
            end
          else
            errors.add(:client, "não conectado.")
          end

          errors.size.zero?
        end

        def destroy
          if client.connected? && update?
            client.variation.destroy(@item_id, @variation_id)
          end
        end

        def self.find(client, item_id, variation_id)
          if client.connected?
            self.new(client, { "item_id" => item_id }.merge(client.variation.find(item_id, variation_id)), { action: 'find' })
          end
        end

        private

          def new_layout
            layout = {}
            layout[:attribute_combinations] = @attribute_combinations
            layout[:price] = @price
            layout[:available_quantity] = @available_quantity
            layout[:picture_ids] = @picture_ids
            layout[:catalog_product_id] = @catalog_product_id
            layout[:attributes] = @attributes
            layout
          end

          def update_layout
            layout = new_layout
            layout.delete(:catalog_product_id)
            layout
          end

      end
    end
  end
end
