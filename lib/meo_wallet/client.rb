require 'httparty'

module MeoWallet
  class Client
    include HTTParty

    base_uri 'https://services.sandbox.meowallet.pt'
    headers 'Content-Type' => 'application/json'

    def initialize(secret)
      self.class.headers 'Authorization' => "WalletPT #{secret}"
    end

    def create_checkout(payment_data)
      self.class.post '/api/v2/checkout', body: payment_data.to_json
    end

    def get_checkout(id)
      self.class.get "/api/v2/checkout/#{id}"
    end

    def checkout_completed?(id)
      get_checkout(id)['payment']['status'] == 'COMPLETED'
    end

    def card_payment(payment_data)
      self.class.post '/prows/v1/payment', body: payment_data.to_json 
    end

    def list_operations
      self.class.get '/api/v2/operations'
    end
    
    def mbway_payment(payment_data)
      self.class.post '/api/v2/payment', body: payment_data.to_json
    end
  end
end
