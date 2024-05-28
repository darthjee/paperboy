# frozen_string_literal: true

require 'spec_helper'

describe Script::WebsitesController do
  let(:decorator) { WebsiteScript::Decorator }

  let(:expected_json) do
    decorator.new(expected_object).to_json
  end

  describe 'GET index' do
    let(:website_scripts_count) { 1 }
    let(:parameters) { { script_id: script.id } }
    let(:script) { create(:script) }

    render_views

    before do
      create_list(:website_script, website_scripts_count, script:)
    end

    context 'when requesting json', :not_cached do
      let(:expected_object) { WebsiteScript.all }

      before do
        get :index, params: parameters.merge(format: :json)
      end

      it { expect(response).to be_successful }

      it 'returns website_scripts serialized' do
        expect(response.body).to eq(expected_json)
      end

      it 'adds page header' do
        expect(response.headers['page']).to eq(1)
      end

      it 'adds pages header' do
        expect(response.headers['pages']).to eq(1)
      end

      it 'adds per_page header' do
        expect(response.headers['per_page']).to eq(50)
      end

      context 'when there are too many website_scripts' do
        let(:website_scripts_count) { 51 }
        let(:expected_object) { WebsiteScript.limit(50) }

        it { expect(response).to be_successful }

        it 'returns website_scripts serialized' do
          expect(response.body).to eq(expected_json)
        end

        it 'adds page header' do
          expect(response.headers['page']).to eq(1)
        end

        it 'adds pages header' do
          expect(response.headers['pages']).to eq(2)
        end

        it 'adds per_page header' do
          expect(response.headers['per_page']).to eq(50)
        end
      end

      context 'when requesting last page' do
        let(:website_scripts_count) { 51 }
        let(:expected_object)   { WebsiteScript.offset(50) }
        let(:parameters)        { { page: 2, script_id: script.id } }

        it { expect(response).to be_successful }

        it 'returns website_scripts serialized' do
          expect(response.body).to eq(expected_json)
        end

        it 'adds page header' do
          expect(response.headers['page']).to eq(2)
        end

        it 'adds pages header' do
          expect(response.headers['pages']).to eq(2)
        end

        it 'adds per_page header' do
          expect(response.headers['per_page']).to eq(50)
        end
      end
    end
  end
end
