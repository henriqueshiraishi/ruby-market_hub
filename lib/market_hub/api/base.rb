# frozen_string_literal: true

module MarketHub
  module API
    # Classe base para todas as integrações (API)
    class Base < MarketHub::Base

      def initialize
      end

      def connected?
        raise MarketHub::NotImplemented, 'Sobreescreva este método na classe referente ao marketplace que você esta criando'
      end

      def find(id)
        raise MarketHub::NotImplemented, 'Sobreescreva este método na classe referente ao marketplace que você esta criando'
      end

      def quantity(id, available_quantity)
        raise MarketHub::NotImplemented, 'Sobreescreva este método na classe referente ao marketplace que você esta criando'
      end

    end
  end
end
