require 'authorizenet'

module SolidusAuthorizenet
  class AuthorizenetClient
    def initialize(options)
      @transaction = Transaction.new(options[:api_login_id], options[:transaction_key], gateway: options[:gateway])
    end

    def authorize(money, source)
      request = CreateTransactionRequest.new
      request.transactionRequest = TransactionRequestType.new
      request.transactionRequest.amount = money
      request.transactionRequest.payment = PaymentType.new
      request.transactionRequest.payment.creditCard = CreditCardType.new(
        source[:credit_card][:number],
        source[:credit_card][:expire],
        source[:credit_card][:cvv]
      )
      request.transactionRequest.customer = CustomerDataType.new(CustomerTypeEnum::Individual,"CUST-1234","bmc@mail.com",DriversLicenseType.new("DrivLicenseNumber123","WA","05/05/1990"),"123456789")
    end

    def capture()
    end

    def void()
    end

    def refund()
    end

    def purchase(money, source, _options = {})
      result = authorize(money, source, _options)
      return result unless result.success?
      capture(money, )
    end
  end
end