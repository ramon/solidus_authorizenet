# frozen_string_literal: true

module SolidusAuthorizenet
  class Configuration
    attr_accessor :api_login_id
    attr_accessor :transaction_key
    attr_accessor :key

    # @!attribute [rw] gateway
    attr_writer :gateway
    def gateway
      @gateway ||= :sandbox
    end
  end

  class << self
    def configuration
      @configuration ||= Configuration.new
    end

    alias config configuration

    def configure
      yield configuration
    end
  end
end
