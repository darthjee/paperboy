# frozen_string_literal: true

FactoryBot.define do
  factory :website_script, class: 'WebsiteScript' do
    website
    script          { build(:script, *[type].compact) }
    sequence(:path) { |n| "/path/to/#{n}" }

    transient do
      type {}
    end

    trait :external_url do
      type { :external_url }
    end

    trait :content do
      type { :content }
    end
  end
end
