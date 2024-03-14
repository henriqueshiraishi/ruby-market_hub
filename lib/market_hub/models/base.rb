# frozen_string_literal: true

module MarketHub
  module Models
    # Classe base para todos os modelos (Models)
    class Base < MarketHub::Base

      include MarketHub::Utils::Validation

      attr_reader :id
      attr_reader :client
      attr_reader :body

      def initialize(client, body = {}, options = {})
        @client = client
        @body = body
        @options = options
      end

      def save
        raise MarketHub::NotImplemented, 'Sobreescreva este método na classe referente ao marketplace que você esta criando'
      end

      def destroy
        raise MarketHub::NotImplemented, 'Sobreescreva este método na classe referente ao marketplace que você esta criando'
      end

      def active!
        raise MarketHub::NotImplemented, 'Sobreescreva este método na classe referente ao marketplace que você esta criando'
      end

      def paused!
        raise MarketHub::NotImplemented, 'Sobreescreva este método na classe referente ao marketplace que você esta criando'
      end

      def new?
        @id ? false : true
      end

      def update?
        !new?
      end

      def self.find(client, id)
        if client.connected?
          self.new(client, client.find(id), { action: 'find' })
        end
      end

      def self.create(client, body)
        if client.connected?
          object = self.new(client, body, { action: 'create' })
          object.save
          object
        end
      end

    end
  end
end
