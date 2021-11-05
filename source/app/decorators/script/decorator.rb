# frozen_string_literal: true

require './app/models/script'

class Script < ApplicationRecord
  class Decorator < ::ModelDecorator
    expose :id

    Script::ALLOWED_ATTRIBUTES.each(&method(:expose))
  end
end
