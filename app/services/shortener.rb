# frozen_string_literal: true

class Shortener
  attr_reader :original_url

  def self.call(original_url)
    new(original_url).call
  end

  def initialize(original_url)
    @original_url = original_url
  end

  def call
    url = Url.find_by(original: original_url)

    url ||= create_url(original_url)
  end

  private

  def create_url(original_url)
    Url.create(
      original: original_url,
      shortened: SecureRandom.hex.first(7)
    )
  end
end
