# frozen_string_literal: true

require 'solidus_authorizenet/configuration'
require 'solidus_authorizenet/version'
require 'solidus_authorizenet/engine'

module SolidusAuthorizenet
  def self.table_name_prefix
    'solidus_authorizenet_'
  end
end