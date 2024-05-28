# frozen_string_literal: true

require 'spec_helper'

describe Website::UserScript do
  subject(:user_script) { described_class.new(website) }

  let(:domain)   { 'localhost' }
  let(:port)     { 3000 }
  let(:protocol) { :http }
  let(:website) do
    create(:website, domain:, port:, protocol:)
  end
  let!(:website_scripts) do
    create_list(:website_script, 3, website:)
  end

  describe '#name' do
    it 'delegates to website' do
      expect(user_script.name).to eq(website.name)
    end
  end

  describe '#location' do
    context 'when everything has been defined' do
      it 'returns the full path' do
        expect(user_script.location).to eq('http://localhost:3000/*')
      end
    end

    context 'when protocol is missing' do
      let(:protocol) { nil }

      it 'adds wild cards for protocol' do
        expect(user_script.location).to eq('*://localhost:3000/*')
      end
    end

    context 'when port is missing' do
      let(:port) { nil }

      it 'adds wild cards for port' do
        expect(user_script.location).to eq('http://localhost:*/*')
      end
    end

    context 'when only domain has been defined' do
      let(:protocol) { nil }
      let(:port)     { nil }

      it 'adds wild cards for protocol and port' do
        expect(user_script.location).to eq('*://localhost:*/*')
      end
    end
  end

  describe '#scripts' do
    let(:expected_scripts) do
      website_scripts.map do |script|
        WebsiteScript::UserScript.new(script)
      end
    end

    it 'wrap website scripts' do
      expect(user_script.scripts).to eq(expected_scripts)
    end
  end
end
