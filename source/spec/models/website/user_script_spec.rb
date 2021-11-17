# frozen_string_literal: true

require 'spec_helper'

fdescribe Website::UserScript, type: :model do
  subject(:user_script) { described_class.new(website) }

  let(:website) { create(:website) }

  describe '#name' do
    it 'delegates to website' do
      expect(user_script.name).to eq(website.name)
    end
  end

  describe '#domain' do
    it 'delegates to website' do
      expect(user_script.domain).to eq(website.domain)
    end
  end

  describe '#scripts' do
    it 'delegates to website' do
      expect(user_script.scripts).to eq(website.scripts)
    end
  end
end
