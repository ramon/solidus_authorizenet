# frozen_string_literal: true

require 'solidus_core'
require 'solidus_support'

module SolidusAuthorizenet
  class Engine < Rails::Engine
    include SolidusSupport::EngineExtensions

    isolate_namespace SolidusAuthorizenet
    engine_name 'solidus_authorizenet'

    initializer "register_solidus_authorizenet_gateway", after: "spree.register.payment_methods" do |app|
      config.to_prepare do
        app.config.spree.payment_methods << ::SolidusAuthorizenet::PaymentMethod

        # ::Spree::PermittedAttributes.source_attributes.concat(
        #   []
        # ).uniq!
      end
    end

    # initializer 'add_solidus_authorizenet_response_to_log_entry_permitted_classes' do
    #   Spree.config do |config|
    #     config.log_entry_permitted_classes << 'SolidusAuthorizenet::Response'
    #   end
    # end

    # if SolidusSupport.api_available?
    #   paths["app/views"] << "lib/views/api"
    # end

    # use rspec for tests
    config.generators do |g|
      g.test_framework :rspec
    end
  end
end
