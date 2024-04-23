# frozen_string_literal: true

FactoryBot.define do
  factory :website, class: 'Website' do
    sequence(:name)   { |n| "Website ###{n}" }
    sequence(:domain) { |n| "www.site-#{n}.com" }
    port              { 80 }
    protocol          { 'http' }
  end
end
