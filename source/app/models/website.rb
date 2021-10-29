# frozen_string_literal: true

class Website < ApplicationRecord
  PROTOCOLS = %w[http https]
  MAX_PORT  = 2**16 - 1

  validates_presence_of :name, :domain
  validates :port,
            numericality: {
              only_integer: true
            },
            inclusion: {
              in: (0..MAX_PORT)
            }
            validates_inclusion_of :protocol, in: PROTOCOLS
end

