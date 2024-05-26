# frozen_string_literal: true

class Website < ApplicationRecord
  class UserScript
    include ExposeWebsite

    attr_reader :website

    delegate :name, :domain, to: :website
    delegate :domain, to: :website

    def initialize(website)
      @website = website
    end

    def scripts
      website.scripts.map do |script|
        WebsiteScript::UserScript.new(script)
      end
    end
  end
end
