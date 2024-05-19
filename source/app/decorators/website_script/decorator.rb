# frozen_string_literal: true

class WebsiteScript < ApplicationRecord
  class Decorator < ::ModelDecorator
    expose :id
    expose :location
    expose :script, decorator: Script::IndexDecorator
    expose :path
    expose :website, decorator: Website::Decorator

    include ExposeWebsite
  end
end
