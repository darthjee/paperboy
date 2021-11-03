# frozen_string_literal: true

require './app/models/script'

class Script < ApplicationRecord
  class IndexDecorator < ::ModelDecorator
    include Rails.application.routes.url_helpers

    expose :id
    expose :url

    def url
      object.external_url.present? ? object.external_url : content_url
    end

    def content_url
      content_domain_script_path(id: object.id, format: :js)
    end
  end
end
