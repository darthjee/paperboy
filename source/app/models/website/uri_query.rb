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
        port:,
        protocol:
      )
    end

    private

    def protocol
      [uri.scheme, nil]
    end

    def port
      [uri.port, nil]
    end

    def uri
      @uri ||= URI.parse(url)
    end
  end
end
