# frozen_string_literal: true

require 'spec_helper'

describe WebsiteScript::UserScript, type: :model do
  subject(:user_script) { described_class.new(website_script) }

  let(:website_script) { create(:website_script, :content) }
  let(:script)         { website_script.script }

  describe '#content' do
    it 'returns script content' do
      expect(user_script.content).to eq(script.content)
    end

    context 'when script has no content' do
      let(:website_script) { create(:website_script, :external_url) }

      it { expect(user_script.content).to be_nil }
    end
  end
end
