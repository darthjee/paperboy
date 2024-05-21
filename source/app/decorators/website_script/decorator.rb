# frozen_string_literal: true

class WebsiteScript < ApplicationRecord
  class Decorator < ::ModelDecorator
    include ExposeWebsite

    expose :id
    expose :location, override: false
    expose :script, decorator: Script::IndexDecorator
    expose :path
    expose :website, decorator: Website::Decorator
  end
end
