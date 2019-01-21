module Moka
  class Payment
    attr_accessor :card_holder_full_name, :card_number, :exp_month, :exp_year,
                  :cvc_number, :amount, :currency, :installment_number, :client_ip,
                  :other_trx_code, :is_pre_auth, :is_pool_payment, :integrator_id,
                  :software, :redirect_url, :redirect_type, :description,
                  :buyer, :credit_card, :card_token,

                  :virtual_post_order_id, :void_refund_reason, :refund_request_id,

                  :response, :result_code

    def initialize(opts = {})
      opts.each do |o|
        send("#{o.first.to_s}=".to_sym, o.last)
      end
    end

    def pay
      response          = RestClient.post Moka.endpoints.direct_payment, payment_hash
      self.response     = JSON.parse(response.body)
      self.result_code  = self.response['ResultCode']
      self.response
    end

    def pay_three_d
      response          = RestClient.post Moka.endpoints.direct_payment_three_d, three_d_payment_hash
      self.response     = JSON.parse(response.body)
      self.result_code  = self.response['ResultCode']
      self.response
    end

    def void
      response          = RestClient.post Moka.endpoinst.void, void_hash
      self.response     = JSON.parse(response.body)
      self.result_code  = self.response['ResultCode']
      self.response
    end

    def refund
      response          = RestClient.post Moka.endpoints.refund, refund_hash
      self.response     = JSON.parse(response.body)
      self.result_code  = self.response['ResultCode']
      self.response
    end

    def success?
      response && response['ResultCode'] == 'Success' && response['Data']['IsSuccessful'] == true
    end

    private
    def payment_hash
      hsh = {
          "PaymentDealerAuthentication": Moka.configuration.config_hash,
          "PaymentDealerRequest": {
              "CardHolderFullName": card_holder_full_name,
              "CardNumber": card_number,
              "ExpMonth": exp_month,
              "ExpYear": exp_year,
              "CvcNumber": cvc_number,
              "CardToken": card_token,
              "Amount": amount,
              "Currency": currency,
              "InstallmentNumber": installment_number || 0,
              "ClientIP": client_ip,
              "OtherTrxCode": other_trx_code,
              "IsPreAuth": is_pre_auth || 0,
              "IsPoolPayment": is_pool_payment || 0,
              "IntegratorId": integrator_id,
              "Software": software,
              "Description": description
          }
      }
      if buyer && buyer.is_a?(Moka::Customer)
        hsh[:PaymentDealerRequest][:BuyerInformation] = {
            "BuyerFullName": buyer.full_name,
            "BuyerEmail": buyer.email,
            "BuyerGsmNumber": buyer.email,
            "BuyerAddress": buyer.address
        }
      end
      hsh
    end

    def three_d_payment_hash
      hsh = payment_hash
      hsh[:PaymentDealerRequest][:RedirectUrl]    = redirect_url
      hsh[:PaymentDealerRequest][:RedirectType]   = redirect_type
      hsh
    end

    def void_hash
      {
          "PaymentDealerAuthentication": Moka.configuration.config_hash,
          "PaymentDealerRequest": {
              "VirtualPosOrderId": virtual_post_order_id,
              "ClientIP": client_ip,
              "VoidRefundReason": void_refund_reason || 2
          }
      }

    end

    def refund_hash
      {
          "PaymentDealerAuthentication": Moka.configuration.config_hash,
          "PaymentDealerRequest": {
              "VirtualPosOrderId": virtual_post_order_id,
              "OtherTrxCode": "",
              "Amount": amount
          }
      }

    end
  end
end