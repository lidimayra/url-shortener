# frozen_string_literal: true

FactoryBot.define do
  factory :url do
    original { 'https://www.website.com' }
    shortened { 'MyString' }
  end
end
