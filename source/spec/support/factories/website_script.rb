# frozen_string_literal: true

FactoryBot.define do
  factory :website_script, class: 'WebsiteScript' do
    website
    script
    sequence(:path)   { |n| "/path/to/#{n}" }
  end
end
