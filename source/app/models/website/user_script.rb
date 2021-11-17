# frozen_string_literal: true

class Website < ApplicationRecord
  class UserScript
    attr_reader :website

    delegate :scripts, :name, to: :website
    delegate :protocol, :domain, :port, to: :website

    def initialize(website)
      @website = website
    end

    def location
      "#{protocol}://#{domain}:#{port}/*"
    end
  end
end
