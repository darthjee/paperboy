# frozen_string_literal: true

class Website < ApplicationRecord
  class UserScript
    attr_reader :website

    delegate :name, to: :website
    delegate :domain, to: :website

    def initialize(website)
      @website = website
    end

    def location
      "#{protocol}://#{domain}:#{port}/*"
    end

    def scripts
      website.scripts.map do |script|
        WebsiteScript::UserScript.new(script)
      end
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
