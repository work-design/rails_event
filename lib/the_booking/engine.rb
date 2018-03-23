module TheBooking
  class Engine < ::Rails::Engine
    config.eager_load_paths += Dir["#{config.root}/app/models/the_booking"]
    config.eager_load_paths += Dir["#{config.root}/app/models/the_booking/concerns"]

  end
end
