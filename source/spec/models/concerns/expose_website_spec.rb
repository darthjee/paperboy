# frozen_string_literal: true

require 'spec_helper'

describe ExposeWebsite do
  subject(:model) { model_class.new(website) }

  let(:model_class) do
    Class.new do
      include(ExposeWebsite)

      attr_reader :website

      def initialize(website)
        @website = website
      end
    end
  end

  describe '#location' do
    let(:website) { build(:website, **attributes) }

    let(:protocol) { %w[http https].sample }
    let(:domain)   { %w[google.com paperboy.net].sample }
    let(:port)     { [80, 8080, 443, 3000].sample }
    let(:expected_protocol) { protocol }
    let(:expected_domain)   { domain }
    let(:expected_port)     { port }
    let(:attributes) do
      {
        protocol: protocol,
        domain: domain,
        port: port
      }
    end

    let(:expected_location) do
      "#{expected_protocol}://#{expected_domain}:#{expected_port}/*"
    end

    context 'when all has been defined' do
      it 'returns an assertive string' do
        expect(model.location).to eq(expected_location)
      end
    end

    context 'when protocol has not been defined' do
      let(:protocol) { nil }
      let(:expected_protocol) { '*' }

      it 'returns an assertive string' do
        expect(model.location).to eq(expected_location)
      end
    end

    context 'when domain has not been defined' do
      let(:domain) { nil }
      let(:expected_domain) { '*' }

      it 'returns an assertive string' do
        expect(model.location).to eq(expected_location)
      end
    end

    context 'when port has not been defined' do
      let(:port) { nil }
      let(:expected_port) { '*' }

      it 'returns an assertive string' do
        expect(model.location).to eq(expected_location)
      end
    end
  end
end
