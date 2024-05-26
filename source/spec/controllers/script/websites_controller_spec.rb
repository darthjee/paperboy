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
      create_list(:website_script, website_scripts_count, script: script)
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
        expect(response.headers['per_page']).to eq(10)
      end

      context 'when there are too many website_scripts' do
        let(:website_scripts_count) { 21 }
        let(:expected_object) { Script.limit(10) }

        it { expect(response).to be_successful }

        it 'returns website_scripts serialized' do
          expect(response.body).to eq(expected_json)
        end

        it 'adds page header' do
          expect(response.headers['page']).to eq(1)
        end

        it 'adds pages header' do
          expect(response.headers['pages']).to eq(3)
        end

        it 'adds per_page header' do
          expect(response.headers['per_page']).to eq(10)
        end
      end

      context 'when requesting last page' do
        let(:website_scripts_count) { 21 }
        let(:expected_object)   { Script.offset(20) }
        let(:parameters)        { { page: 3 } }

        it { expect(response).to be_successful }

        it 'returns website_scripts serialized' do
          expect(response.body).to eq(expected_json)
        end

        it 'adds page header' do
          expect(response.headers['page']).to eq(3)
        end

        it 'adds pages header' do
          expect(response.headers['pages']).to eq(3)
        end

        it 'adds per_page header' do
          expect(response.headers['per_page']).to eq(10)
        end
      end
    end

    context 'when requesting html and ajax is true', :cached do
      before do
        get :index, params: { format: :html, ajax: true }
      end

      it { expect(response).to be_successful }

      it { expect(response).to render_template('website_scripts/index') }
    end

    context 'when requesting html and ajax is false' do
      before do
        get :index
      end

      it { expect(response).to redirect_to('#/website_scripts') }
    end
  end
end
