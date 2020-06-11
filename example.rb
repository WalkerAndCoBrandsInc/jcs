lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

require 'jcs'
require 'logger'

JCS.configure do |config|
  config.api_root = ''
  config.partner_name = 'Your company'
  config.partner_password = ''
  config.customer_id = '12345'
  config.debug = true
  config.logger = Logger.new(STDOUT)
end

options = {}
transmission = JCS::SalesOrder.new(options)
transmission.send_request
