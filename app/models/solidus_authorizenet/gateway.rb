require 'active_merchant'

module SolidusAuthorizenet
  class Gateway < ::Spree::PaymentMethod::CreditCard
    preference(:login, :string)
    preference(:transaction_key, :string)

    def payment_source_class
      Source
    end

    def source_required?
      true
    end

    def payment_profiles_supported?
      true
    end

    def authorizenet
      @authorizenet ||= ActiveMerchant::Billing::AuthorizeNetGateway.new(gateway_options)
    end

    def gateway_options
      {
        login: api_login_id,
        password: transaction_key,
        test: test
      }
    end

    protected def gateway_class
      ActiveMerchant::Billing::AuthorizeNetGateway
    end

    # @param [Numeric, String] amount
    # @param [Source] payment
    # @param [Hash] options
    def authorize(amount, payment, options = {})
      authorizenet.authorize(amount, payment, options)
    end

    # @param [Numeric, String] amount
    # @param [Source] payment
    # @param [Hash] options
    def purchase(amount, payment, options = {})
      authorizenet.purchase(amount, payment, options)
    end

    # @param [Numeric, String] amount
    # @param [String] authorization
    # @param [Hash] options
    def capture(amount, authorization, options = {})
      authorizenet.capture(amount, authorization, options)
    end

    def void(authorization, options = {})
      authorizenet.void(authorization, options = {})
    end

    # @param [Numeric, String] amount
    # @param [String] payment
    # @param [Hash] options
    def credit(amount, payment, options = {})
      authorizenet.credit(amount, payment, options)
    end

    def cancel(amount, authorization, options = {})
      authorizenet.refund(amount, authorization, options)
    end

    # @param [Spree::Payment] payment
    def create_profile(payment)
      source = payment.source
    end
  end
end