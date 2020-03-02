# frozen_string_literal: true

class UrlsController < ApplicationController
  skip_before_action :verify_authenticity_token

  def create
    url = Shortener.call(url_params[:original])
    render json: { url: url, errors: url.errors },
           status: (url&.valid? ? :created : :unprocessable_entity)
  end

  private

  def url_params
    params.require(:url).permit(:original)
  end
end
