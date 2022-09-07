# frozen_string_literal: true

class WebsiteScript < ApplicationRecord
  class UserScript
    attr_reader :website_script

    delegate :path, :script, to: :website_script

    def initialize(website_script)
      @website_script = website_script
    end

    def content
      script.content&.html_safe
    end

    def ==(other)
      return false unless other.is_a?(self.class)

      other.website_script == website_script
    end
  end
end
