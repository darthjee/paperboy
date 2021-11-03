# frozen_string_literal: true

require './app/models/script'

class Script < ApplicationRecord
  class IndexDecorator < ::ModelDecorator
    expose :id
    expose :url

    def url
      external_url
    end
  end
end
