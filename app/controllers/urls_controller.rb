# frozen_string_literal: true

class UrlsController < ApplicationController
  def create
    set_url
    set_shortened_url
    render 'home/index', status: (@url&.valid? ? :created : :bad_request)
  end

  private

  def set_url
    original = url_params[:original]
    @url = Url.find_by(original: original, shortened: Shortener.call(original))
  end

  def set_shortened_url
    @shortened_url = "#{request.base_url}/#{@url.shortened}" if @url&.valid?
  end

  def url_params
    params.require(:url).permit(:original)
  end
end
