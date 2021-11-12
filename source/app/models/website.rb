# frozen_string_literal: true

class Website < ApplicationRecord
  PROTOCOLS          = %w[http https].freeze
  MAX_PORT           = 2**16 - 1
  ALLOWED_ATTRIBUTES = %i[name domain port protocol].freeze

  has_many :scripts, class_name: :WebsiteScript

  validates :name,
            presence: true,
            length: { maximum: 100 }
  validates :domain,
            presence: true,
            length: { maximum: 100 }
  validates :port,
            numericality: {
              only_integer: true,
              less_than_or_equal_to: MAX_PORT,
              greater_than: 0
            },
            allow_nil: true

  validates :protocol,
            inclusion: {
              in: PROTOCOLS
            },
            allow_nil: true

  scope :for, ->(url) { UriQuery.new(self, url).websites }
end
