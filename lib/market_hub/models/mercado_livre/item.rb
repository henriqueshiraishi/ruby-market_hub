# frozen_string_literal: true

module MarketHub
  module Models
    module MercadoLivre
      # Classe que representa um Item no Mercado Livre
      class Item < MarketHub::Models::Base

        attr_accessor :item_id, :title, :description, :category_id, :price, :available_quantity, :sale_terms, :listing_type_id, :condition, :pictures,
                      :video_id, :local_pick_up, :free_shipping, :attributes, :status, :catalog_product_id, :channel_markeplace, :channel_mshops

        validates_presence_of :title, :category_id, :price, :available_quantity, :listing_type_id, :attributes, message: 'não pode estar em branco.'

        def initialize(client, body = {}, options = {})
          super(client, body, options)
          unless body.empty?
            @id = body.dig(:item_id) || body.dig('id')
            @item_id = body.dig(:item_id) || body.dig('id')
            @title = body.dig(:title) || body.dig('title')
            @description = body.dig(:description) || (client.description.find(@item_id).dig('plain_text') if options[:action] == 'find' && @item_id)
            @category_id = body.dig(:category_id) || body.dig('category_id')
            @price = (body.dig(:price) || body.dig('price')).to_f
            @available_quantity = body.dig(:available_quantity) || body.dig('available_quantity')
            @sale_terms = body.dig(:sale_terms) || body.dig('sale_terms')
            @listing_type_id = body.dig(:listing_type_id) || body.dig('listing_type_id')
            @condition = body.dig(:condition) || body.dig('condition')
            @pictures = body.dig(:pictures) || body.dig('pictures')
            @video_id = body.dig(:video_id) || body.dig('video_id')
            @local_pick_up = body.dig(:local_pick_up) || body.dig('shipping', 'local_pick_up')
            @free_shipping = body.dig(:free_shipping) || body.dig('shipping', 'free_shipping')
            @attributes = body.dig(:attributes) || body.dig('attributes')
            @status = body.dig(:status) || body.dig('status')
            @catalog_product_id = body.dig(:catalog_product_id) || body.dig('catalog_product_id')
            @channel_markeplace = (body.dig('channels') ? body.dig('channels').include?("marketplace") : body.dig(:channel_markeplace))
            @channel_mshops = (body.dig('channels') ? body.dig('channels').include?("mshops") : body.dig(:channel_mshops))
          end
        end

        def item_id=(value)
          @id = value
          @item_id = value
        end

        def save
          if client.connected?
            if valid?
              @was_new = new?
              @was_update = update?

              if new?
                json = client.item.create(new_layout)
              else
                json = client.item.update(@item_id, update_layout)
              end

              if json['id']
                @id = json['id']
                @item_id = json['id']
                if !@description.to_s.empty? && (@was_new || client.description.find(@item_id).empty?)
                  client.description.create(@item_id, @description)
                else
                  client.description.update(@item_id, @description)
                end
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
            client.item.destroy(@item_id)
          end
        end

        def active!
          @status = 'active'
          save
        end

        def paused!
          @status = 'paused'
          save
        end

        private

          def new_layout
            layout = {}
            layout[:title] = @title
            layout[:category_id] = @category_id
            layout[:price] = @price
            layout[:currency_id] = Configuration.default.currency_id
            layout[:available_quantity] = @available_quantity
            layout[:sale_terms] = @sale_terms
            layout[:buying_mode] = "buy_it_now"
            layout[:listing_type_id] = @listing_type_id
            layout[:condition] = @condition
            layout[:pictures] = @pictures
            layout[:video_id] = @video_id
            layout[:shipping] = { local_pick_up: @local_pick_up, free_shipping: @free_shipping }
            layout[:attributes] = @attributes
            layout[:status] = @status
            layout[:catalog_product_id] = @catalog_product_id
            layout[:catalog_listing] = !(@catalog_product_id.to_s == "")
            layout[:channels] = []
            layout[:channels].push("marketplace") if @channel_markeplace
            layout[:channels].push("mshops") if @channel_mshops
            layout
          end

          def update_layout
            @has_bids = (client.item.find(@item_id).dig('sold_quantity').to_i > 0) unless @has_bids

            layout = new_layout
            if @has_bids
              layout.delete(:title)
              layout.delete(:category_id)
              layout.delete(:condition)
            end
            layout.delete(:currency_id)
            layout.delete(:buying_mode)
            layout.delete(:listing_type_id)
            layout.delete(:catalog_product_id)
            layout.delete(:catalog_listing)
            layout
          end

      end
    end
  end
end
