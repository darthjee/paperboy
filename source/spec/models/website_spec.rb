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
  end
end
