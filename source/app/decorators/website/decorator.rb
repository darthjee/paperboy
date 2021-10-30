# frozen_string_literal: true

require './app/models/website'

class Website < ApplicationRecord
  class Decorator < ::ModelDecorator
    Website::ALLOWED_ATTRIBUTES.each(&method(:expose))

    expose :id
    expose :name
    expose :domain
    expose :port
    expose :protocol

    expose :errors, if: :invalid?
  end
end
