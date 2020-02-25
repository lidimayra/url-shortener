# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Urls', type: :request do
  let(:path) { '8e47cad' }

  describe 'get /show' do
    subject(:get_index) { get "/#{path}" }

    context 'when url is not found' do
      it 'raises not found' do
        expect { get_index }.to raise_error ActiveRecord::RecordNotFound
      end
    end

    context 'when url is found' do
      before do
        create :url, shortened: path, original: 'http://www.website.com'
      end

      it 'returns http found' do
        get_index
        expect(response).to have_http_status(:found)
      end

      it { is_expected.to redirect_to 'http://www.website.com' }
    end
  end
end
