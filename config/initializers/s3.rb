# Be sure to restart your server when you modify this file.

# This file contains settings for ActionController::ParamsWrapper which
# is enabled by default.

CarrierWave.configure do |config|
  config.fog_credentials = {
      :provider               => 'AWS',
      :region                 => 'us-west-2' # Change this for different AWS region. Default is 'us-east-1'
  }
end
# To enable root element in JSON for ActiveRecord objects.
# ActiveSupport.on_load(:active_record) do
#   self.include_root_in_json = true
# end
