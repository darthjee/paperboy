# frozen_string_literal: true

class Website < ApplicationRecord
  class UriQuery
    attr_reader :scope, :url

    def initialize(scope, url)
      @scope = scope
      @url   = url
    end

    def websites
      scope.where(
        domain: uri.host,
        port: uri.port,
        protocol: uri.scheme
      )
    end

    private

    def uri
      @uri ||= URI.parse(url)
    end
  end
end
