# frozen_string_literal: true

require 'spec_helper'

describe WebsiteScriptsController do
  let(:decorator) { WebsiteScript::Decorator }

  let(:expected_json) do
    decorator.new(expected_object).to_json
  end

  describe 'GET index' do
    let(:website) do
      create(:website, port: port, protocol: protocol, domain: domain)
    end
    let(:other_website) { create(:website) }

    let(:uri)             { URI.parse(url) }
    let(:url)             { 'https://www.google.com' }
    let(:domain)          { uri.host }
    let(:port)            { uri.port }
    let(:protocol)        { uri.scheme }

    let!(:website_scripts) do
      create_list(:website_script, 3, website: website)
    end

    before { create(:website_script, website: other_website) }

    context 'when finding more than one website', :not_cached do
      let(:expected_object) { WebsiteScript.all }

      let(:other_website) do
        create(:website, port: nil, protocol: nil, domain: domain)
      end

      before do
        get :index, params: { format: :json, url: url }
      end

      it { expect(response).to be_successful }

      it 'returns scripts serialized' do
        expect(response.body).to eq(expected_json)
      end
    end

    context 'when requesting for the domain', :not_cached do
      let(:expected_object) { website_scripts }

      before do
        get :index, params: { format: :json, url: url }
      end

      it { expect(response).to be_successful }

      it 'returns scripts serialized' do
        expect(response.body).to eq(expected_json)
      end
    end

    context 'when not finding a website config', :not_cached do
      let(:expected_object) { [] }
      let(:domain) { 'other.com' }

      before do
        get :index, params: { format: :json, url: url }
      end

      it { expect(response).to be_successful }

      it 'returns scripts serialized' do
        expect(response.body).to eq(expected_json)
      end
    end
  end
end
