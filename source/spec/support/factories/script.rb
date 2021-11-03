# frozen_string_literal: true

FactoryBot.define do
  factory :script, class: 'Script' do
    sequence(:name) { |n| "Script ###{n}" }
    external_url    { 'http://www.scriptserver.com' }
  end

  trait :external_url do
    external_url { 'http://www.scriptserver.com' }
    content      { nil }
  end

  trait :content do
    external_url { nil }
    content      { 'alert("hello");' }
  end
end
