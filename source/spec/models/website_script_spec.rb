# frozen_string_literal: true

require 'spec_helper'

describe WebsiteScript, type: :model do
  subject(:website_script) { build(:website_script) }

  describe 'validations' do
    it do
      expect(website_script).to validate_presence_of(:website)
    end

    it do
      expect(website_script).to validate_presence_of(:script)
    end

    it do
      expect(website_script).not_to validate_presence_of(:path)
    end

    it do
      expect(website_script).to validate_length_of(:path)
        .is_at_most(255)
    end
  end
end
