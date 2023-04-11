require 'active_merchant'

module SolidusAuthorizenet
  class PaymentMethod < Spree::PaymentMethod
    preference :api_login_id, :string
    preference :transaction_key, :string

    def partial_name
      'gateway'
    end

    def payment_source_class
      Source
    end

    def supports?(source)
      source.is_a?(payment_source_class)
    end

    # @param [Spree::Order] order
    def reusable_sources(order)
      return [] unless order.user

      order.user.wallet_payment_sources.map(&:payment_source).select do |source|
        supports?(source) && source.reusable?
      end
    end

    protected def gateway_class
      ::ActiveMerchant::Billing::AuthorizeNetGateway
    end

    def options
      {
        login: self.preferred_api_login_id,
        password: self.preferred_transaction_key,
        test: self.preferred_test_mode
      }
    end

    def try_void(payment)
      return false if payment.completed?

      void(payment.source.transaction_id)
    end

    # @param [SolidusAuthorizenet::Source] source
    def authorize(money, source, options = {})
      gateway.authorize(money, source.to_active_merchant, options)
    end

    # @param [SolidusAuthorizenet::Source] source
    def purchase(money, source, options = {})
      gateway.purchase(money, source.to_active_merchant, options)
    end

    def credit(money, authorization_id, options = {})
      gateway.refund(money, authorization_id, options)
    end
  end
end