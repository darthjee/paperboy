# frozen_string_literal: true

require 'spec_helper'

describe Script::IndexDecorator do
  subject(:decorator) { described_class.new(object) }

  let(:attributes) { %w[id url] }
  let(:decorator_json) { JSON.parse(decorator.to_json) }

  describe '#to_json' do
    context 'when object is one entity' do
      let(:object) { create(:script, type) }
      let(:type)   { :external_url }

      let(:expected_json) do
        {
          id: object.id,
          url: object.external_url
        }.deep_stringify_keys
      end

      it 'returns expected json' do
        expect(decorator_json).to eq(expected_json)
      end

      context 'when script has content' do
        let(:type) { :content }
        
        let(:expected_json) do
          {
            id: object.id,
            url: nil,
          }.deep_stringify_keys
        end

        it 'returns the script content route' do
          expect(decorator_json).to eq(expected_json)
        end
      end

      context 'when object is invalid but object has not been validated' do
        let(:object) do
          build(:script, name: nil)
        end

        it 'returns expected json without errors' do
          expect(decorator_json).to eq(expected_json)
        end
      end

      context 'when object is invalid and object has been validated' do
        let(:object) do
          build(:script, name: nil)
        end

        let(:expected_errors) do
          {
            name: ["can't be blank"]
          }
        end

        let(:expected_json) do
          {
            id: object.id,
            url: object.external_url,
            errors: expected_errors
          }.deep_stringify_keys
        end

        before { object.valid? }

        it 'returns expected json with errors' do
          expect(decorator_json).to eq(expected_json)
        end
      end
    end

    context 'when object is a collection' do
      let(:object) { build_list(:script, 3) }

      let(:expected_json) do
        object.map do |script|
          {
            id: script.id,
            url: script.external_url
          }
        end.as_json
      end

      it 'returns expected json' do
        expect(decorator_json).to eq(expected_json)
      end

      context 'when object is a collection of invalid not validated objects' do
        let(:object) { build_list(:script, 3, name: nil) }

        it 'returns expected json without errors' do
          expect(decorator_json).to eq(expected_json)
        end
      end

      context 'when object is a collection with invalid ivalidated objects' do
        before { object.each(&:valid?) }

        let(:expected_errors) do
          {
            name: ["can't be blank"]
          }
        end

        let(:object) { build_list(:script, 3, name: nil) }

        let(:expected_json) do
          object.map do |script|
            {
              id: script.id,
              url: script.external_url,
              errors: expected_errors
            }
          end.as_json
        end

        it 'returns expected json' do
          expect(decorator_json).to eq(expected_json)
        end
      end
    end
  end
end
