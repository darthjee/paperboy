# frozen_string_literal: true

require 'spec_helper'

describe Website, type: :model do
  subject(:website) { build(:website) }

  describe 'validations' do
    it do
      expect(website).to validate_presence_of(:name)
    end

    it do
      expect(website).to validate_length_of(:name)
        .is_at_most(100)
    end

    it do
      expect(website).to validate_presence_of(:domain)
    end

    it do
      expect(website).to validate_length_of(:domain)
        .is_at_most(100)
    end

    it do
      expect(website).not_to validate_presence_of(:port)
    end

    it do
      expect(website).to validate_numericality_of(:port)
        .is_greater_than(0)
    end

    it do
      expect(website).to validate_numericality_of(:port)
        .is_less_than_or_equal_to(described_class::MAX_PORT)
    end

    it do
      expect(website).not_to validate_presence_of(:protocol)
    end

    it do
      expect(website).to validate_inclusion_of(:protocol)
        .in_array(described_class::PROTOCOLS)
    end
  end
end
