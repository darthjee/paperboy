# frozen_string_literal: true

class Website < ApplicationRecord
  PROTOCOLS = %w[http https].freeze
  MAX_PORT  = 2**16 - 1

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
end
