# frozen_string_literal: true

require './app/models/script'

class Script < ApplicationRecord
  class IndexDecorator < ::ModelDecorator
    include Rails.application.routes.url_helpers

    expose :id
    expose :name
    expose :url
    expose :format

    def format
      external_url.present? ? :url : :path
    end

    def url
      external_url.present? ? external_url : content_url
    end

    def content_url
      content_domain_script_path(id: id, format: :js)
    end
  end
end
