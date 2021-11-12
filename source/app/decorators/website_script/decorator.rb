# frozen_string_literal: true

require './app/models/website_script'

class WebsiteScript < ApplicationRecord
  class Decorator < ::ModelDecorator
    expose :id
    expose :script, decorator: Script::IndexDecorator
    expose :path
  end
end
