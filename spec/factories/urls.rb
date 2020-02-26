# frozen_string_literal: true

FactoryBot.define do
  factory :url do
    original { 'https://www.website.com' }
    shortened { '9c38JnA' }
  end
end
