# frozen_string_literal: true

require 'rails_helper'

describe 'User fills URL form', type: :feature, js: true do
  let(:h1) { page.find('h1') }

  before do
    allow(SecureRandom).to receive(:hex).and_return('f9b5f21')
    visit root_path
  end

  it 'accesses the homepage' do
    expect(page).not_to have_selector '#original'
    expect(page).not_to have_selector '#shortened'
    expect(h1).to have_text 'URL Shortener'
  end

  context 'when selecting a different language' do
    it 'renders a translated page' do
      click_link 'German'
      expect(h1).to have_text 'URL Kürzer'
    end
  end

  context 'when filling the form with a valid URL' do
    it 'renders input and output data to the user' do
      fill_in 'url_original', with: 'https://www.somewebsite.com'
      page.find('input[type="submit"]').click

      expect(page.find('#original')).to have_text 'https://www.somewebsite.com'
      expect(page.find('#shortened')).to have_text '/f9b5f21'
    end
  end

  context 'when filling the form with an invalid URL' do
    let(:alert) { page.find('.alert') }

    context 'without a locale' do
      it 'renders error messages in default language' do
        fill_in 'url_original', with: 'Invalid'
        page.find('input[type="submit"]').click

        expect(alert).to have_text 'Enter a valid URL and try again.'
      end
    end

    context 'with a locale' do
      it 'renders error messages in the selected language' do
        click_link 'Portuguese'
        fill_in 'url_original', with: 'Invalid'
        page.find('input[type="submit"]').click

        expect(alert).to have_text 'Informe uma URL válida e tente novamente.'
      end
    end
  end
end
