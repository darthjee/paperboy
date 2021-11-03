# frozen_string_literal: true

require 'spec_helper'

describe Script, type: :model do
  subject(:script) { build(:script) }

  describe 'validations' do
    it do
      expect(script).to validate_presence_of(:name)
    end

    it do
      expect(script).to validate_length_of(:name)
        .is_at_most(100)
    end

    it do
      expect(script).not_to validate_presence_of(:external_url)
    end

    it do
      expect(script).to validate_length_of(:external_url)
        .is_at_most(255)
    end
  end
end
