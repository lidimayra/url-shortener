# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Shortener do
  let(:original) { 'http://www.original.com' }
  let(:shortened) { 'https://www.localhost:3000/ijwn6xq' }

  describe '.call' do
    subject(:call) { described_class.call(original) }

    context 'when original URL already exists' do
      before { create(:url, original: original, shortened: shortened) }

      it { expect(call.shortened).to eq shortened }
    end

    context 'when original URL does not exist' do
      let(:url) { Url.find_by(original: original) }

      before do
        allow(SecureRandom).to receive(:hex).and_return('f9b5f21')
        call
      end

      it { expect(url).to be_present }
      it { expect(url.shortened).to eq 'f9b5f21' }
    end
  end
end
