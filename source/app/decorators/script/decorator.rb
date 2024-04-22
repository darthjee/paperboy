# frozen_string_literal: true

class Script < ApplicationRecord
  class Decorator < ::ModelDecorator
    expose :id

    Script::ALLOWED_ATTRIBUTES.each(&method(:expose))
  end
end
