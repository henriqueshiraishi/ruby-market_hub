# frozen_string_literal: true

module MarketHub
  module API
    module MercadoLivre
      # Classe para integrar/autenticar com o Mercado Livre
      class Authorization

        def initialize( client_id = MarketHub.configure.client_id,
                        client_secret = MarketHub.configure.client_secret,
                        redirect_uri = MarketHub.configure.redirect_uri)
          @oauth20 = MarketHub::Utils::OAuth20.new(client_id, client_secret, redirect_uri)
        end

        def authorize_url(state = nil)
          @oauth20.authorize_url('auth.mercadolivre.com.br', '/authorization', state)
        end

        def get_token(code)
          @oauth20.get_token('api.mercadolibre.com', '/oauth/token', code)
        end

        def renew_token(refresh_token)
          @oauth20.renew_token('api.mercadolibre.com', '/oauth/token', refresh_token)
        end
  
      end
    end
  end
end
