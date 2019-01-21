module Moka
  class Card
    attr_accessor :dealer_customer_id, :customer_code, :card_holder_full_name,
                  :card_number, :exp_month, :exp_year, :card_name, :card_token,
                  :bank_name, :card_number_first_six, :card_number_last_four,
                  :customer, :response

    def initialize(opts = {})
      opts.each do |o|
        send("#{o.first.to_s}=".to_sym, o.last)
      end
    end

    def create
      response        = RestClient.post Moka.endpoints.add_card, create_hash
      self.response   = JSON.parse(response)
    end

    def update
      response        = RestClient.post Moka.endpoints.update_card, update_hash
      self.response   = JSON.parse(response)
    end

    def get
      response        = RestClient.post Moka.endpoints.get_card, get_and_delete_hash
      self.response   = JSON.parse(response)
    end

    def delete
      response        = RestClient.post Moka.endpoints.get_card, get_and_delete_hash
      self.response   = JSON.parse(response)
    end

    def success?
      response && response['ResultCode'] == 'Success'
    end

    private
    def create_hash
      {
          "DealerCustomerAuthentication": Moka.configuration.config_hash,
          "DealerCustomerRequest": {
              "DealerCustomerId": dealer_customer_id,
              "CustomerCode": customer_code,
              "CardHolderFullName": card_holder_full_name,
              "CardNumber": card_number,
              "ExpMonth": exp_month,
              "ExpYear": exp_year,
              "CardName": card_name
          }
      }
    end

    def update_hash
      {
          "DealerCustomerAuthentication": Moka.configuration.config_hash,
          "DealerCustomerRequest": {
              "CardToken": card_token,
              "CardName": card_name
          }
      }
    end

    def get_and_delete_hash
      {
          "DealerCustomerAuthentication": Moka.configuration.config_hash,
          "DealerCustomerRequest": {
              "CardToken": card_token
          }
      }
    end
  end
end