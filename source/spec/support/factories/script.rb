# frozen_string_literal: true

FactoryBot.define do
  factory :script, class: 'Script' do
    sequence(:name) { |n| "Script ###{n}" }
    external_url    { "http://www.scriptserver.com" }
  end
end