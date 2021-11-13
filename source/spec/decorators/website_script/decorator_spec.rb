# frozen_string_literal: true

require 'spec_helper'

describe WebsiteScript::Decorator do
  subject(:decorator) { described_class.new(object) }

  let(:attributes) { %w[id url] }
  let(:decorator_json) { JSON.parse(decorator.to_json) }

  describe '#to_json' do
    context 'when object is one entity' do
      let(:object) { create(:website_script, script: script) }
      let(:script) { create(:script, type) }
      let(:type)   { :external_url }

      let(:expected_json) do
        {
          id: object.id,
          path: object.path,
          script: {
            id: script.id,
            name: script.name,
            url: script.external_url,
            format: 'url'
          }
        }.deep_stringify_keys
      end

      it 'returns expected json' do
        expect(decorator_json).to eq(expected_json)
      end

      context 'when script has content' do
        let(:type)       { :content }
        let(:url_helper) { Rails.application.routes.url_helpers }

        let(:expected_path) do
          url_helper.content_website_script_path(id: script.id, format: :js)
        end

        let(:expected_json) do
          {
            id: object.id,
            path: object.path,
            script: {
              id: script.id,
              name: script.name,
              url: expected_path,
              format: 'path'
            }
          }.deep_stringify_keys
        end

        it 'returns the script content route' do
          expect(decorator_json).to eq(expected_json)
        end
      end

      context 'when object is invalid but object has not been validated' do
        let(:object) { build(:website_script, script: script) }
        let(:script) do
          build(:script, name: nil)
        end

        it 'returns expected json without errors' do
          expect(decorator_json).to eq(expected_json)
        end
      end

      context 'when object is invalid and object has been validated' do
        let(:object) { build(:website_script, script: script) }
        let(:script) do
          build(:script, name: nil)
        end

        let(:expected_errors) do
          {
            script: ['is invalid']
          }
        end

        let(:expected_script_errors) do
          {
            name: ["can't be blank"]
          }
        end

        let(:expected_json) do
          {
            id: object.id,
            path: object.path,
            errors: expected_errors,
            script: {
              id: script.id,
              name: script.name,
              url: script.external_url,
              format: 'url',
              errors: expected_script_errors
            }
          }.deep_stringify_keys
        end

        before { object.valid? }

        it 'returns expected json with errors' do
          expect(decorator_json).to eq(expected_json)
        end
      end
    end

    context 'when object is a collection' do
      let(:object) { build_list(:website_script, 3) }

      let(:expected_json) do
        object.map do |obj|
          {
            id: obj.id,
            path: obj.path,
            script: {
              id: obj.script.id,
              name: obj.script.name,
              url: obj.script.external_url,
              format: 'url'
            }
          }
        end.as_json
      end

      it 'returns expected json' do
        expect(decorator_json).to eq(expected_json)
      end
    end
  end
end
