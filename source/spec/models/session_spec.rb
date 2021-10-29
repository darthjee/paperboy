# frozen_string_literal: true

require 'spec_helper'

describe Session do
  describe 'scopes' do
    describe '.active' do
      let!(:session) do
        create(:session, expiration: expiration)
      end

      context 'when session has expiration in the future' do
        let(:expiration) { 2.days.from_now }

        it do
          expect(described_class.active).to include(session)
        end
      end

      context 'when session has expiration in the past' do
        let(:expiration) { 2.days.ago }

        it do
          expect(described_class.active).not_to include(session)
        end
      end

      context 'when session has no expiration' do
        let(:expiration) { nil }

        it do
          expect(described_class.active).to include(session)
        end
      end
    end
  end
end
