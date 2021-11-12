# frozen_string_literal: true

require 'spec_helper'

describe WebsiteScriptsController do
  let(:decorator) { WebsiteScript::Decorator }

  let(:expected_json) do
    decorator.new(expected_object).to_json
  end

  describe 'GET index' do
    let(:website) do
      create(:website, port: port, protocol: protocol, port: port)
    end

    let!(:other_script) { create(:website_script) }
    let!(:website_scripts) do
      create_list(:website_script, 3, website: website)
    end

    context 'when requesting for the domain', :not_cached do
      let(:expected_object) { website_scripts }
      let(:uri)             { URI.parse(url) }
      let(:url)             { "https://www.google.com" }
      let(:domain)          { uri.host }
      let(:port)            { uri.port }
      let(:protocol)        { uri.scheme }

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
