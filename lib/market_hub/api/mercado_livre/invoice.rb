# frozen_string_literal: true

module MarketHub
  module API
    module MercadoLivre
      # Classe API de Nota Fiscal de Produto
      class Invoice

        attr_accessor :access_token
        attr_accessor :site_id

        def initialize(access_token, site_id)
          @access_token = access_token
          @site_id = site_id
        end

        def find(shipment_id)
          host = MarketHub.configure.meli_api_uri
          path = "/shipments/#{shipment_id}/invoice_data"
          params = { siteId: @site_id }
          endpoint = URI::HTTPS.build(host: host, path: path)
          endpoint.query = URI.encode_www_form(params)
          response = MarketHub::HTTP.get(endpoint, headers: { authorization: "Bearer #{@access_token}" })
          try_to_convert_to_json(response.body)
        end

        def create(shipment_id, invoice_data)
          host = MarketHub.configure.meli_api_uri
          path = "/shipments/#{shipment_id}/invoice_data"
          params = { siteId: @site_id }
          endpoint = URI::HTTPS.build(host: host, path: path)
          endpoint.query = URI.encode_www_form(params)
          response = MarketHub::HTTP.post(endpoint, headers: { authorization: "Bearer #{@access_token}", 'Content-Type' => 'application/xml' }, body: invoice_data)
          JSON.parse(response.body)
        end

        def update(shipment_id, invoice_data)
          host = MarketHub.configure.meli_api_uri
          path = "/shipments/#{shipment_id}/invoice_data"
          params = { siteId: @site_id }
          endpoint = URI::HTTPS.build(host: host, path: path)
          endpoint.query = URI.encode_www_form(params)
          response = MarketHub::HTTP.put(endpoint, headers: { authorization: "Bearer #{@access_token}", 'Content-Type' => 'application/xml' }, body: invoice_data)
          JSON.parse(response.body)
        end

        def errors
          {
            shipment_invoice_already_saved: { message: 'Já existe uma nota fiscal salva para o envio informado.', hit: 'Para que a nota fiscal possa ser salva, o envio necessita estar no substatus de invoice_pending, para verificar se o envio se encontra nesse substatus, consulte /shipments/{shipment_id}, ou consulte se já não foi salva a nota fiscal para o envio informado através do endpoint /shipments/{id}/invoice_data.' },
            duplicated_fiscal_key: { message: 'Já existe uma nota fiscal salva com a chave fiscal informada.', hit: 'O número de chave fiscal da nota precisa ser único.' },
            wrong_invoice_date: { message: 'A data informada na nota fiscal é inválida.', hit: 'Verifique a data informada.' },
            wrong_sender_zipcode: { message: 'O CEP do vendedor informado na nota fiscal é inválido ou nulo.', hit: 'Verifique o CEP do vendedor informado.' },
            wrong_receiver_zipcode: { message: 'O CEP do comprador informado na nota fiscal é inválido ou nulo.', hit: 'Verifique o CEP do comprador informado.' },
            wrong_receiver_cnpj: { message: 'O CNPJ do comprador informado na nota fiscal é inválido ou nulo.', hit: 'Verifique o CNPJ do comprador informado.' },
            wrong_receiver_cpf: { message: 'O CPF do comprador informado na nota fiscal é inválido ou nulo.', hit: 'Verifique o CPF do comprador informado.' },
            wrong_receiver_state_tax: { message: 'A Inscrição Estadual do comprador informada na nota fiscal é inválida ou nula.', hit: 'Verifique a Inscrição Estadual do comprador informada.' },
            invalid_user: { message: 'Você não tem permissão para realizar operações no envio informado.', hit: 'Verifique o número de envio informado e se você tem permissões sobre ele.' },
            seller_not_allowed_to_import_nfe: { message: 'Você não tem permissão para realizar a importação de NF-e', hit: 'Verifique se você tem permissão para importar notas fiscais ou use nosso emissor de notas fiscais.' },
            shipment_invoice_should_contain_company_state_tax_id: { message: 'A Inscrição Estadual do comprador não foi informada na nota fiscal.', hit: 'Verifique a Inscrição Estadual do comprador informada.' },
            invalid_state_tax_id: { message: 'A Inscrição Estadual do comprador informada na nota fiscal é inválida ou nula.', hit: 'Verifique a Inscrição Estadual do comprador informada.' },
            invalid_operation_for_site_id: { message: 'Operação inválida para a região informada.', hit: 'Só é permitida a execução de operações para o site MLB.' },
            error_parse_invoice_data: { message: 'Erro ao converter dados da nota fiscal para json.', hit: 'Verifique se a nota fiscal foi informada de forma correta.' },
            invalid_parameter: { message: 'A nota fiscal informada não contém o número de identificação.', hit: 'Verifique o número de identificação na nota fiscal informada.' },
            invalid_caller_id: { message: 'Caller Id informado é inválido ou não foi informado.', hit: 'Verifique se o Caller Id esta sendo informado ao realizar o request.' },
            sender_ie_not_found: { message: 'O cnpj do vendedor não está cadastrado na Sefaz como contribuinte ou está bloqueado.', hit: 'Não é possível informar a NF-e porque seus dados cadastrados no Mercado Livre são diferentes dos que você tem cadastrados na SEFAZ. Revise o CNPJ, a Inscrição Estadual (IE) e o estado (UF). Corrija as informações do seu cadastro no Mercado Livre e tente novamente.' },
            invalid_sender_ie_for_state: { message: 'A inscrição estadual do vendedor é inválida para o estado cadastrado.', hit: 'Não é possível informar a NF-e porque seu dado de IE cadastrado no Mercado Livre está incorreto para o estado cadastrado no endereço. Revise o CNPJ, a Inscrição Estadual (IE) e o estado (UF). Corrija as informações do seu cadastro no Mercado Livre e tente novamente.' },
            invalid_sender_ie: { message: 'A inscrição estadual do vendedor é diferente da cadastrada junto à Sefaz.', hit: 'Não é possível informar a NF-e porque seus dados cadastrados no Mercado Livre são diferentes dos que você tem cadastrados na SEFAZ. Revise a Inscrição Estadual (IE). Corrija as informações do seu cadastro no Mercado Livre e tente novamente' },
            invalid_sender_cnpj: { message: 'O CNPJ do vendedor é diferente do cadastrado junto à Sefaz.', hit: 'Não é possível informar a NF-e porque seus dados cadastrados no Mercado Livre são diferentes dos que você tem cadastrados na SEFAZ. Revise o CNPJ. Corrija as informações do seu cadastro no Mercado Livre, e tente novamente.' },
            different_state_nfe_shipment_origin: { message: 'A UF da nota é diferente do estado de origem do envio.', hit: 'Não é possível informar a NF-e porque a UF do XML da nota é diferente da UF onde o envio foi gerado. Corrija as informações do XML e tente novamente.' },
            nfe_order_value_divergence: { message: 'O valor da nota fiscal diverge do valor total dos itens do pedido.', hit: 'O valor da NF-e é diferente do valor da venda. Confira os valores preenchidos como preço, descontos e frete e emita uma nova nota com o valor corrigido' },
            wrong_invoice_type: { message: 'Nota fiscal de serviço ou contem valor de ISSQN', hit: 'Emita uma NF-e de venda para seus produtos. Notas fiscais de serviços não são aceitas no Mercado Livre.' },
            unexpected_error_post_biller: { message: 'XML invalido ou com campos incorretos.', hit: 'Enviar XML no formato aprovado pelo emissor de nota fiscal e validado pelo governo.' },
            shipment_already_being_processed: { message: 'Foi enviada mais de uma requisição ao mesmo tempo,', hit: 'Aguardar o processamento da primeira requisição.' },
            batch_nfe_not_supported: { message: 'Não é possível informar nota fiscal com formato em lote', hit: 'Enviar XML de uma nota fiscal individual' },
            nfe_layout_not_supported: { message: 'Não é possível informar nota fiscal com esse formato', hit: 'Enviar XML de uma nota fiscal no formato aprovado pelo emissor fiscal e validado pelo governo do seu estado, seguindo a estrutura correta do XML com as tags: , ,' },
            nf_already_generated: { message: 'Já existe uma NFe emitida pelo faturador.', hit: 'Verifique o status da NFe. Caso a NFe esteja anulada ou inutilizada, emitir novamente pelo faturador.' },
            internal_error: { message: 'Houve um erro interno', hit: 'Aguarde e tente novamente.' },
            invalid_shipment: { message: 'O shipment se encontra em um status em que a importação da NF-e não é aceita', hit: 'Verifique o status do shipment antes de enviar a NF-e.' }
          }
        end

        private

          def try_to_convert_to_json(body)
            JSON.parse(body)
          rescue
            body
          end

      end
    end
  end
end
