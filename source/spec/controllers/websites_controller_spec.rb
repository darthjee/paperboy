# frozen_string_literal: true

require 'spec_helper'

describe WebsitesController do
  let(:expected_json) do
    Website::Decorator.new(expected_object).to_json
  end

  describe 'GET new' do
    render_views

    context 'when requesting html and ajax is true', :cached do
      before do
        get :new, params: { format: :html, ajax: true }
      end

      it { expect(response).to be_successful }

      it { expect(response).to render_template('websites/new') }
    end

    context 'when requesting html and ajax is false' do
      before do
        get :new
      end

      it do
        expect(response).to redirect_to('#/websites/new')
      end
    end

    context 'when requesting json', :not_cached do
      let(:expected_object) { Website.new }

      before do
        get :new, params: { format: :json }
      end

      it { expect(response).to be_successful }

      it 'returns websites serialized' do
        expect(response.body).to eq(expected_json)
      end
    end
  end

  describe 'GET index' do
    let(:websites_count) { 1 }
    let(:parameters) { {} }

    render_views

    before { create_list(:website, websites_count) }

    context 'when requesting json', :not_cached do
      let(:expected_object) { Website.all }

      before do
        get :index, params: parameters.merge(format: :json)
      end

      it { expect(response).to be_successful }

      it 'returns websites serialized' do
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

      context 'when there are too many websites' do
        let(:websites_count) { 21 }
        let(:expected_object) { Website.limit(10) }

        it { expect(response).to be_successful }

        it 'returns websites serialized' do
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
        let(:websites_count)  { 21 }
        let(:expected_object) { Website.offset(20) }
        let(:parameters)      { { page: 3 } }

        it { expect(response).to be_successful }

        it 'returns websites serialized' do
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

      it { expect(response).to render_template('websites/index') }
    end

    context 'when requesting html and ajax is false' do
      before do
        get :index
      end

      it { expect(response).to redirect_to('#/websites') }
    end
  end

  describe 'POST create' do
    context 'when requesting json format' do
      let(:website) { Website.last }

      let(:parameters) do
        { format: :json, website: payload }
      end

      let(:payload) do
        {
          name: 'my website',
          domain: 'www.mysite.com',
          port: 100,
          protocol: 'http'
        }
      end

      let(:expected_object) { website }

      it do
        post :create, params: parameters

        expect(response).to be_successful
      end

      it do
        expect { post :create, params: parameters }
          .to change(Website, :count)
          .by(1)
      end

      context 'when the request is completed' do
        before { post :create, params: parameters }

        let(:website) { Website.last }

        let(:website_attributes) do
          website.attributes.reject do |key, _|
            %w[id created_at updated_at]
              .include? key
          end
        end

        let(:expected_website_attributes) do
          payload.stringify_keys
        end

        it 'returns created website' do
          expect(response.body).to eq(expected_json)
        end

        it 'creates a correct website' do
          expect(website_attributes)
            .to eq(expected_website_attributes)
        end
      end

      context 'when there are validation errors' do
        let(:payload) { { name: 'my site' } }

        let(:website_attributes) do
          payload
        end

        let(:website) do
          Website.new(website_attributes).tap(&:valid?)
        end

        it 'is not successful' do
          post :create, params: parameters

          expect(response).not_to be_successful
        end

        it 'does not create a new website' do
          expect { post :create, params: parameters }
            .not_to change(Website, :count)
        end

        it 'returns website with errors' do
          post :create, params: parameters

          expect(response.body).to eq(expected_json)
        end
      end
    end
  end

  describe 'GET show' do
    render_views

    let(:website)    { create(:website) }
    let(:website_id) { website.id }

    context 'when requesting html and ajax is true', :cached do
      before do
        get :show, params: { format: :html, ajax: true, id: website_id }
      end

      it { expect(response).to be_successful }

      it { expect(response).to render_template('websites/show') }
    end

    context 'when requesting html and ajax is false' do
      before do
        get :show, params: { id: website_id }
      end

      it do
        expect(response).to redirect_to("#/websites/#{website_id}")
      end
    end

    context 'when requesting json', :not_cached do
      let(:expected_object) { website }

      before do
        get :show, params: { id: website_id, format: :json }
      end

      it { expect(response).to be_successful }

      it 'returns websites serialized' do
        expect(response.body).to eq(expected_json)
      end
    end
  end

  describe 'GET user_script' do
    render_views

    let(:website) { create(:website) }

    let!(:website_scripts) do
      create_list(:website_script, 3, website: website, type: :content)
    end

    before do
      get :user_script, params: { format: :js, website_id: website.id }
    end

    it { expect(response).to be_successful }

    it 'returns websites scripts as user script' do
      expect(response.body).to include(website_scripts.sample.script.content)
    end
  end
end
