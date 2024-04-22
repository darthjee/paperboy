# frozen_string_literal: true

class Session < ApplicationRecord
  scope :active, -> { where('expiration IS NULL OR expiration > ?', Time.now) }

  belongs_to :user
end
