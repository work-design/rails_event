# frozen_string_literal: true

require 'rails_com'
module RailsEvent
  class Engine < ::Rails::Engine

    config.autoload_paths += Dir[
      "#{config.root}/app/models/rails_event/concerns",
      "#{config.root}/app/models/plan_participant"
    ]

    config.factory_bot.definition_file_paths += Dir["#{config.root}/test/factories"] if defined?(FactoryBotRails)

    config.generators do |g|
      g.rails = {
        assets: false,
        stylesheets: false,
        helper: false,
        jbuilder: true
      }
      g.test_unit = {
        fixture: true,
        fixture_replacement: :factory_girl
      }
      g.templates.unshift File.expand_path('lib/templates', RailsCom::Engine.root)
    end

  end
end
