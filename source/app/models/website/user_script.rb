# frozen_string_literal: true

class Website < ApplicationRecord
  class UserScript
    attr_reader :website

    delegate :scripts, :name, to: :website
    delegate :domain, to: :website

    def initialize(website)
      @website = website
    end

    def location
      "#{protocol}://#{domain}:#{port}/*"
    end

    private

    def protocol
      website.protocol || '*'
    end

    def port
      website.port || '*'
    end
  end
end
