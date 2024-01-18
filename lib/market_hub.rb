# frozen_string_literal: true

require 'json'
require 'net/http'
require 'uri'

require 'market_hub/base'
require 'market_hub/configuration'
require 'market_hub/exception'
require 'market_hub/version'

require 'market_hub/utils/o_auth_20'

require 'market_hub/models/base'
require 'market_hub/models/mercado_livre/item'
require 'market_hub/models/mercado_livre/order'

require 'market_hub/api/base'
require 'market_hub/api/mercado_livre/client'

require 'market_hub/client'

module MarketHub
  # Personalize as configurações padrão da biblioteca usando bloco
  #   MarketHub.configure do |config|
  #     config.username = "xxx"
  #     config.password = "xxx"
  #   end
  # Se nenhum bloco for fornecido, retorna o objeto de configuração padrão
  def self.configurate
    if block_given?
      yield(Configuration.default)
    else
      Configuration.default
    end
  end
end
