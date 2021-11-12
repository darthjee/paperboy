# frozen_string_literal: true

class Website < ApplicationRecord
  class UriQuery
    attr_reader :scope, :url

    def initialize(scope, url)
      @scope = scope
      @url   = url
    end

    def websites
      scope
    end

    private

    def uri
      @uri ||= UIR.parse(url)
    end
  end
end
