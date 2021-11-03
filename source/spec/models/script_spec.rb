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
      expect(script).not_to validate_presence_of(:content)
    end

    it do
      expect(script).to validate_length_of(:content)
        .is_at_most(2**16 - 1)
    end

    it do
      expect(script).not_to validate_presence_of(:external_url)
    end

    it do
      expect(script).to validate_length_of(:external_url)
        .is_at_most(255)
    end

    context "when external_url is empty" do
      subject(:script) { build(:script, external_url: nil) }

      it do
        expect(script).to validate_presence_of(:content)
      end
    end
  end
end
