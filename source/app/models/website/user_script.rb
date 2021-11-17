# frozen_string_literal: true

class Website < ApplicationRecord
  class UserScript
    attr_reader :website

    delegate :scripts, :name, :domain, to: :website

    def initialize(website)
      @website = website
    end
  end
end
