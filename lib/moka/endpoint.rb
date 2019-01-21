module Moka
  class Endpoint
    BASE_URL        = 'https://service.moka.com'
    TEST_BASE_URL   = 'https://service.testmoka.com'

    ENDPOINTS       = {
      # Payment Options
      direct_payment: '/PaymentDealer/DoDirectPayment',
      direct_payment_three_d: '/PaymentDealer/DoDirectPaymentThreeD',
      capture: '/PaymentDealer/DoCapture',
      approve_pool_payment: '/PaymentDealer/DoApprovePoolPayment',
      void: '/PaymentDealer/DoVoid',
      refund: '/PaymentDealer/DoCreateRefundRequest',
      get_payment_list: '/PaymentDealer/GetPaymentList',
      get_transaction_list: '/PaymentDealer/GetPaymentTrxList',
      get_payment_detail_list: '/PaymentDealer/GetDealerPaymentTrxDetailList',

      # Customer Options
      add_customer: '/DealerCustomer/AddCustomer',
      update_customer: '/DealerCustomer/UpdateCustomer',
      get_customer: '/DealerCustomer/GetCustomer',
      remove_customer: '/DealerCustomer/RemoveCustomer',
      add_customer_with_card: '/DealerCustomer/AddCustomerWithCard',

      # Card Options
      add_card: '/DealerCustomer/AddCard',
      update_card: '/DealerCustomer/UpdateCard',
      get_card: '/DealerCustomer/GetCard',
      get_card_list: '/DealerCustomer/GetCardList',
      remove_card: '/DealerCustomer/RemoveCard'
    }

    ENDPOINTS.each_key do |attribute|
      attr_accessor attribute
    end

    def initialize
      base_url = Moka.configuration.test? ? TEST_BASE_URL : BASE_URL
      ENDPOINTS.each do |attribute, value|
        send("#{attribute}=".to_sym, "#{base_url}#{value}")
      end
    end
  end
end