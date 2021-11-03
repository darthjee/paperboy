# frozen_string_literal: true

class Script < ApplicationRecord
  MAX_CONTENT_SIZE = 2**16 - 1

  validates :name,
            presence: true,
            length: { maximum: 100 }
  validates :external_url,
            length: { maximum: 255 }
  validates :content,
            length: { maximum: MAX_CONTENT_SIZE }
end
