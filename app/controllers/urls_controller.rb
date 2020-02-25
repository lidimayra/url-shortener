# frozen_string_literal: true

class UrlsController < ApplicationController
  protect_from_forgery unless: -> { request.format.json? }

  def create
    path = Shortener.call(url_params[:original])
    render json: { path: path }, status: status
  end

  private

  def url_params
    params.require(:url).permit(:original)
  end
end
