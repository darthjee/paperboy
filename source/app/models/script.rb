# frozen_string_literal: true

class Script < ApplicationRecord
  MAX_CONTENT_SIZE = (2**16) - 1
  REQUIRED_CONTENT_MESSAGE = 'Content or external url are required'
  EXCLUSIVE_CONTENT_MESSAGE = 'Content and external url are mutually exclusive'
  ALLOWED_ATTRIBUTES = %i[name content external_url].freeze

  validates :name,
            presence: true,
            length: { maximum: 100 }
  validates :external_url,
            length: { maximum: 255 }
  validates :content,
            length: { maximum: MAX_CONTENT_SIZE }
  validates :content,
            presence: { message: REQUIRED_CONTENT_MESSAGE },
            if: -> { external_url.blank? }
  validates :content,
            absence: { message: EXCLUSIVE_CONTENT_MESSAGE },
            if: -> { external_url.present? }
end
