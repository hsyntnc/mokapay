module Moka
  class Customer
    attr_accessor :dealer_customer_id, :customer_code, :password, :first_name, :last_name,
                  :gender, :birth_date, :gsm_number, :email, :address,
                  :credit_card, :card_list, :response

    def initialize(opts = {})
      opts.each do |o|
        send(o.first, o.last)
      end
    end

    def full_name
      "#{first_name} #{last_name}"
    end

    def create
      response        = RestClient.post Moka.endpoints.add_customer, create_hash
      self.response   = JSON.parse(response)
    end

    def get
      response        = RestClient.post Moka.endpoints.add_customer, get_and_delete_hash
      self.response   = JSON.parse(response)
    end

    def update
      response        = RestClient.post Moka.endpoints.add_customer, update_hash
      self.response   = JSON.parse(response)
    end

    def delete
      response        = RestClient.post Moka.endpoints.add_customer, get_and_delete_hash
      self.response   = JSON.parse(response)
    end

    def add_with_card
      response        = RestClient.post Moka.endpoints.add_customer_with_card, get_and_delete_hash
      self.response   = JSON.parse(response)
    end

    def success?
      response && response['ResultCode'] == 'Success'
    end

    private
    def create_hash(with_card = false)
      hsh = {
          "DealerCustomerAuthentication": Moka.configuration.config_hash,
          "DealerCustomerRequest": {
              "CustomerCode": customer_code,
              "Password": password,
              "FirstName": first_name,
              "LastName": last_name,
              "Gender": gender,
              "BirthDate": birth_date,
              "GsmNumber": gsm_number,
              "Email": email,
              "Address": address
          }
      }

      if with_card && credit_card && credit_card.is_a?(Moka::Card)
        hsh[:DealerCustomerRequest][:CardHolderFullName]  = credit_card.card_holder_full_name
        hsh[:DealerCustomerRequest][:CardNumber]          = credit_card.card_number
        hsh[:DealerCustomerRequest][:ExpMonth]            = credit_card.exp_month
        hsh[:DealerCustomerRequest][:ExpYear]             = credit_card.exp_year
        hsh[:DealerCustomerRequest][:CardName]            = credit_card.card_name
      end

      hsh
    end

    def update_hash
      {
          "DealerCustomerAuthentication": Moka.configuration.config_hash,
          "DealerCustomerRequest": {
              "DealerCustomerId": dealer_customer_id,
              "CustomerCode": customer_code,
              "Password": password,
              "FirstName": first_name,
              "LastName": last_name,
              "Gender": gender,
              "BirthDate": birth_date,
              "GsmNumber": gsm_number,
              "Email": email,
              "Address": address
          }
      }

    end

    def get_and_delete_hash
      {
          "DealerCustomerAuthentication": Moka.configuration.config_hash,
          "DealerCustomerRequest": {
              "DealerCustomerId": dealer_customer_id,
              "CustomerCode": customer_code
          }
      }
    end
  end
end