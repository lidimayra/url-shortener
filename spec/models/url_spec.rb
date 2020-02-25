# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Url, type: :model do
  subject { build :url }

  it { is_expected.to be_valid }
  it { is_expected.to validate_presence_of(:original) }
  it { is_expected.to validate_presence_of(:shortened) }
  it { is_expected.to validate_uniqueness_of(:original) }
  it { is_expected.to validate_uniqueness_of(:shortened) }
end
