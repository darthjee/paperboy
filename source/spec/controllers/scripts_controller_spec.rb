# frozen_string_literal: true

require 'spec_helper'

describe ScriptsController do
  let(:decorator) { Script::Decorator }

  let(:expected_json) do
    decorator.new(expected_object).to_json
  end

  describe 'GET new' do
    render_views

    context 'when requesting html and ajax is true', :cached do
      before do
        get :new, params: { format: :html, ajax: true }
      end

      it { expect(response).to be_successful }

      it { expect(response).to render_template('scripts/new') }
    end

    context 'when requesting html and ajax is false' do
      before do
        get :new
      end

      it do
        expect(response).to redirect_to('#/scripts/new')
      end
    end

    context 'when requesting json', :not_cached do
      let(:expected_object) { Script.new }

      before do
        get :new, params: { format: :json }
      end

      it { expect(response).to be_successful }

      it 'returns scripts serialized' do
        expect(response.body).to eq(expected_json)
      end
    end
  end

  describe 'GET index' do
    let(:decorator) { Script::IndexDecorator }

    let(:scripts_count) { 1 }
    let(:parameters) { {} }

    render_views

    before { create_list(:script, scripts_count) }

    context 'when requesting json', :not_cached do
      let(:expected_object) { Script.all }

      before do
        get :index, params: parameters.merge(format: :json)
      end

      it { expect(response).to be_successful }

      it 'returns scripts serialized' do
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

      context 'when there are too many scripts' do
        let(:scripts_count) { 21 }
        let(:expected_object) { Script.limit(10) }

        it { expect(response).to be_successful }

        it 'returns scripts serialized' do
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
        let(:scripts_count) { 21 }
        let(:expected_object)   { Script.offset(20) }
        let(:parameters)        { { page: 3 } }

        it { expect(response).to be_successful }

        it 'returns scripts serialized' do
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

      it { expect(response).to render_template('scripts/index') }
    end

    context 'when requesting html and ajax is false' do
      before do
        get :index
      end

      it { expect(response).to redirect_to('#/scripts') }
    end
  end

  describe 'POST create' do
    context 'when requesting json format' do
      let(:size)      { 100 }
      let(:lethality) { 0.5 }
      let(:script) { Script.last }

      let(:parameters) do
        { format: :json, script: payload }
      end

      let(:payload) do
        {
          name: 'my script',
          content: 'alert("my script");',
          external_url: ''
        }
      end

      let(:expected_object) { script }

      it do
        post :create, params: parameters

        expect(response).to be_successful
      end

      it do
        expect { post :create, params: parameters }
          .to change(Script, :count)
          .by(1)
      end

      context 'when the request is completed' do
        before { post :create, params: parameters }

        let(:script) { Script.last }

        let(:script_attributes) do
          script.attributes.reject do |key, _|
            %w[id created_at updated_at]
              .include? key
          end
        end

        let(:expected_script_attributes) do
          payload.stringify_keys
        end

        it 'returns created script' do
          expect(response.body).to eq(expected_json)
        end

        it 'creates a correct script' do
          expect(script_attributes)
            .to eq(expected_script_attributes)
        end
      end

      context 'when there are validation errors' do
        let(:payload) { { name: 'my site' } }

        let(:script_attributes) do
          payload
        end

        let(:script) do
          Script.new(script_attributes).tap(&:valid?)
        end

        it 'is not successful' do
          post :create, params: parameters

          expect(response).not_to be_successful
        end

        it 'does not create a new script' do
          expect { post :create, params: parameters }
            .not_to change(Script, :count)
        end

        it 'returns script with errors' do
          post :create, params: parameters

          expect(response.body).to eq(expected_json)
        end
      end
    end
  end

  describe 'GET show' do
    render_views

    let(:script)    { create(:script) }
    let(:script_id) { script.id }

    context 'when requesting html and ajax is true', :cached do
      before do
        get :show, params: { format: :html, ajax: true, id: script_id }
      end

      it { expect(response).to be_successful }

      it { expect(response).to render_template('scripts/show') }
    end

    context 'when requesting js', :cached do
      before do
        get :show, params: { format: :html, ajax: true, id: script_id }
      end

      it { expect(response).to be_successful }

      it do
        expect(response.body).to eq(script.content)
      end
    end

    context 'when requesting html and ajax is false' do
      before do
        get :show, params: { id: script_id }
      end

      it do
        expect(response).to redirect_to("#/scripts/#{script_id}")
      end
    end

    context 'when requesting json', :not_cached do
      let(:expected_object) { script }

      before do
        get :show, params: { id: script_id, format: :json }
      end

      it { expect(response).to be_successful }

      it 'returns scripts serialized' do
        expect(response.body).to eq(expected_json)
      end
    end
  end
end
