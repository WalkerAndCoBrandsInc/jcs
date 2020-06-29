require "nokogiri"
require "faraday"
require "faraday_middleware"
require "require_all"
require "securerandom"
require "jcs/version"
require_rel 'jcs/*.rb'
require_rel 'jcs/elements/*.rb'
require_rel 'jcs/inbound_elements/*.rb'
require 'jcs/transmissions/standard_response'
require_rel 'jcs/transmissions/*.rb'

module Jcs
  GEM_DIR = (File.dirname(__FILE__) + '/../').freeze

  def self.configuration
    @configuration ||= Jcs::Configuration.new
  end

  def self.configure
    yield configuration
    configuration.assert_valid
  end

  # This method checks the shipping configuration of the gem. If the user of the
  # gem is using international schema, then this method will return false and
  # vice versa. This configuration determines which sales order submission
  # schema is used when submitting sales order submission requests to Jcs
  # Micro.
  #
  # Returns:
  #   Boolean
  def self.domestic_schema?
    Jcs.configuration.international_schema ? false : true
  end

  def self.generate_order_number(prefix = '')
    "#{prefix}#{SecureRandom.random_number(89999) + 10000}"
  end

  class InvalidType < StandardError; end
  class MissingField < StandardError; end
  class XMLSchemaMismatch < StandardError; end

  SHIPPING_METHODS = {
    'FX01'   => 'FedEx Standard Overnight',
    'FXAM'   => 'FedEx Priority Overnight',
    'FX2D'   => 'FedEx Second Day',
    'FXSP'   => 'FedEx Smart Post',
    'FXIE'   => 'FedEx International Economy',
    'FXIP'   => 'FedEx International Priority',
    'FXSV'   => 'FedEx Express saver (3 day)',
    'USPP'   => 'Postal Priority',
    'FXL1'   => 'FedEx Freight Overnight (Air)',
    'FXL2'   => 'FedEx Freight 2-day (Air)',
    'FXL3'   => 'FedEx Freight 3-day (Air)',
    'FXLE'   => 'FedEx Freight Ground',
    'GGRNDP' => 'Ground shipping',
   }.freeze
end
