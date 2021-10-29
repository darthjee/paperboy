# frozen_string_literal: true

class Website < ApplicationRecord
  PROTOCOLS = %w[http https]

  validates_presence_of :name, :domain
  validates :port,
            numericality: {
              greater_than_or_equal_to: 0,
              only_integer: true
            }
  validates_inclusion_of :protocol, in: PROTOCOLS
end

