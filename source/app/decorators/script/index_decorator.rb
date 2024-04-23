# frozen_string_literal: true

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
      # TODO fix script_path
      # script_path(id: id, format: :js)
    end
  end
end
