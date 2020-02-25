# frozen_string_literal: true

class RedirectController < ApplicationController
  def show
    url = Url.find_by!(shortened: params[:short_path])
    redirect_to url.original
  end
end
