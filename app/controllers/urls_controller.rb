# frozen_string_literal: true

class UrlsController < ApplicationController
  def create
    @original = url_params[:original]
    @url = "#{request.base_url}/#{Shortener.call(url_params[:original])}"
    render 'home/index'
  end

  private

  def url_params
    params.require(:url).permit(:original)
  end
end
