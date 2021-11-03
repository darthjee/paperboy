# frozen_string_literal: true

require './app/models/script'

class Script < ApplicationRecord
  class IndexDecorator < ::ModelDecorator
    expose :id
    expose :url

    def url
      object.external_url.present? ? object.external_url : nil
    end
  end
end
