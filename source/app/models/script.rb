# frozen_string_literal: true

class Script < ApplicationRecord
  validates :name,
            presence: true,
            length: { maximum: 100 }
  validates :external_url,
            length: { maximum: 255 }
end
