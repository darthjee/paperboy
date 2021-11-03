# frozen_string_literal: true

require './app/models/website'

class Website < ApplicationRecord
  class Decorator < ::ModelDecorator
    expose :id

    Website::ALLOWED_ATTRIBUTES.each(&method(:expose))
  end
end
