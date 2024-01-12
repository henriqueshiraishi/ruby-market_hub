# frozen_string_literal: true

module MarketHub
  # Classe base para parametrização da biblioteca
  class Configuration

    def initialize
    end

    def self.default
      @default ||= Configuration.new
    end

  end
end
