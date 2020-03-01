# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Urls', type: :request do
  describe 'get /index' do
    subject { get '/urls' }

    it { is_expected.to redirect_to root_path }
  end

  describe 'post /create' do
    subject(:post_create) { post '/urls', params: { url: { original: url } } }

    context 'with a valid URL' do
      let(:url) { 'http://www.bla.com' }

      before { post_create }

      it { expect(response).to have_http_status(:created) }
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
