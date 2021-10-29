# frozen_string_literal: true

class Website < ApplicationRecord
  PROTOCOLS = %w[http https]
  MAX_PORT  = 2**16 - 1

  validates :name,
            presence: true,
            length: { maximum: 100 }
  validates :domain,
            presence: true,
            length: { maximum: 100 }
  validates :port,
            numericality: {
              only_integer: true
            },
            inclusion: {
              in: (0..MAX_PORT)
            }
            validates_inclusion_of :protocol, in: PROTOCOLS
end

