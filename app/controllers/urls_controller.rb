# frozen_string_literal: true

class UrlsController < ApplicationController
  around_action :switch_locale

  def index
    redirect_to root_path
  end

  def create
    set_url
    set_shortened_url
    render json: { url: @url, errors: @url.errors },
           status: (@url&.valid? ? :created : :unprocessable_entity)
  end

  private

  def set_url
    original = url_params[:original]
    @url = Shortener.call(original)
  end

  def set_shortened_url
    @shortened_url = "#{request.base_url}/#{@url.shortened}" if @url&.valid?
  end

  def url_params
    params.require(:url).permit(:original)
  end
end
