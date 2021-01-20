# frozen_string_literal: true

require 'rails_event/config'
require 'rails_event/engine'

module Eventual

  def self.use_relative_model_naming?
    true
  end

end
