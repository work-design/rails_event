# frozen_string_literal: true

require 'active_support/configurable'

module RailsEvent #:nodoc:
  include ActiveSupport::Configurable

  configure do |config|
    config.app_controller = 'ApplicationController'
    config.my_controller = 'MyController'
    config.admin_controller = 'AdminController'
    config.membership_controller = 'MembershipController'
  end

end


