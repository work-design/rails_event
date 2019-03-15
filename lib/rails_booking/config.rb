require 'active_support/configurable'

module RailsBooking #:nodoc:
  include ActiveSupport::Configurable

  configure do |config|
    config.my_class = 'MyController'
    config.admin_class = 'AdminController'
    config.disabled_models = [
      'AlipayUser',
      'WechatUser'
    ]
    config.default_return_path = '/'
    config.ignore_return_paths = [
      'login',
      'join'
    ]
  end

end


