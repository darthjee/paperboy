# frozen_string_literal: true

class WebsiteScript < ApplicationRecord
  belongs_to :website
  belongs_to :script

  validates_presence_of :website, :script
  validates :path,
            length: { maximum: 255 }
end

