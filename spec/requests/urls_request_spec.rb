# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Urls', type: :request do
  describe 'post /create' do
    subject(:post_create) { post '/urls', params: { url: { original: url } } }

    context 'with a valid URL' do
      let(:url) { 'http://www.bla.com' }

      it 'returns http created' do
        post_create
        expect(response).to have_http_status(:created)
      end
    end

    context 'with an invalid URL' do
      let(:url) { 'blablabla' }

      it 'returns http bad request' do
        post_create
        expect(response).to have_http_status(:bad_request)
      end
    end
  end
end
