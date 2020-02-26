# frozen_string_literal: true

require 'rails_helper'

describe 'User fills URL form', type: :feature do
  before do
    allow(SecureRandom).to receive(:hex).and_return('f9b5f21')
    visit root_path
  end

  it 'accesses the homepage' do
    expect(page).not_to have_selector '#original'
    expect(page).not_to have_selector '#shortened'
  end

  context 'when filling the form with a valid URL' do
    it 'renders input and output data to the user' do
      fill_in 'url_original', with: 'https://www.somewebsite.com'
      click_button 'commit'

      expect(page.find('#original')).to have_text 'https://www.somewebsite.com'
      expect(page.find('#shortened')).to have_text 'http://www.example.com/f9b5f21'
    end
  end

  context 'when filling the form with an invalid URL' do
    it 'renders error messages' do
      fill_in 'url_original', with: 'Invalid'
      click_button 'commit'

      expect(page.find('.alert')).to have_text 'is not a valid URL'
    end
  end
end