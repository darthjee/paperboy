# frozen_string_literal: true

require 'spec_helper'

describe WebsiteScriptsController do
  let(:decorator) { WebsiteScript::Decorator }

  let(:expected_json) do
    decorator.new(expected_object).to_json
  end

  describe 'GET index' do
    let!(:website_scripts) { create_list(:website_script, 3) }

    context 'when requesting json', :not_cached do
      let(:expected_object) { website_scripts }

      before do
        get :index, params: { format: :json }
      end

      it { expect(response).to be_successful }

      it 'returns scripts serialized' do
        expect(response.body).to eq(expected_json)
      end
    end
  end
end

