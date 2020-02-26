# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Urls', type: :request do
  describe 'post /create' do
    subject(:post_create) do
      post '/urls', params: { url: { original: 'http://www.bla.com' } }
    end

    it 'returns http success' do
      post_create
      expect(response).to have_http_status(:success)
    end
  end
end
