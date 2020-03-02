# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Urls', type: :request do
  describe 'post /create' do
    subject(:post_create) { post '/urls', params: { url: { original: url } } }

    context 'with a valid URL' do
      let(:url) { 'http://www.bla.com' }
      let(:response_url) { JSON.parse(response.body)['url'] }

      before { post_create }

      it { expect(response).to have_http_status(:created) }
      it { expect(response_url['original']).to eq url }
      it { expect(response_url['shortened']).to be_present }
    end

    context 'with an invalid URL' do
      let(:url) { 'blablabla' }

      it 'returns http bad request' do
        post_create
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'returns error message' do
        post_create
        errors = JSON.parse(response.body)['errors']
        expect(errors['original']).to include 'is not a valid URL'
      end
    end
  end
end
