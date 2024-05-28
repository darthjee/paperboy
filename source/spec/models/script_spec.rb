# frozen_string_literal: true

require 'spec_helper'

describe Script do
  subject(:script) do
    build(:script, content:, external_url:)
  end

  let(:external_url) { 'www.site.com' }
  let(:content)      { [nil, ''].sample }

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
        .is_at_most((2**16) - 1)
    end

    it do
      expect(script).not_to validate_presence_of(:external_url)
    end

    it do
      expect(script).to validate_length_of(:external_url)
        .is_at_most(255)
    end

    context 'when external_url is empty' do
      let(:external_url) { [nil, ''].sample }

      it do
        expect(script).to validate_presence_of(:content)
          .with_message(described_class::REQUIRED_CONTENT_MESSAGE)
      end
    end

    context 'when content is not empty' do
      let(:content) { 'My content' }

      it do
        expect(script).to validate_absence_of(:content)
          .with_message(described_class::EXCLUSIVE_CONTENT_MESSAGE)
      end
    end
  end
end
