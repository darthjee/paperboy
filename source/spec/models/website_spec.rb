# frozen_string_literal: true

require 'spec_helper'

describe Website do
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

  describe 'scopes' do
    let(:website) { create(:website, domain: 'www.google.com') }
    let(:url) { 'http://www.google.com' }

    describe '.for' do
      context 'when url matches the website' do
        it 'returns the scoped website' do
          expect(described_class.for(url)).to include(website)
        end
      end

      context 'when adtional scope excludes the website' do
        it 'returns the scoped website' do
          expect(described_class.where(port: 900).for(url))
            .not_to include(website)
        end
      end

      context 'when url does not matches the website' do
        let(:url) { 'http://www.googly.com' }

        it 'does not return the scoped website' do
          expect(described_class.for(url)).not_to include(website)
        end
      end
    end
  end
end
