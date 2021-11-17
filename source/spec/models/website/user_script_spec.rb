# frozen_string_literal: true

require 'spec_helper'

fdescribe Website::UserScript, type: :model do
  subject(:user_script) { described_class.new(website) }

  let(:domain)   { 'localhost' }
  let(:port)     { 3000 }
  let(:protocol) { :http }
  let(:website) do
    create(:website, domain: domain, port: port, protocol: protocol)
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
      let(:protocol) {  nil }

      xit 'adds wild cards for protocol' do
        expect(user_script.location).to eq('*://localhost:3000/*')
      end
    end

    context 'when port is missing' do
      let(:port) { nil }

      xit 'adds wild cards for port' do
        expect(user_script.location).to eq('http://localhost:*/*')
      end
    end

    context 'when only domain has been defined' do
      let(:protocol) { nil }
      let(:port)     { nil }

      xit 'adds wild cards for protocol and port' do
        expect(user_script.location).to eq('*://localhost:*/*')
      end
    end
  end

  describe '#scripts' do
    it 'delegates to website' do
      expect(user_script.scripts).to eq(website.scripts)
    end
  end
end
