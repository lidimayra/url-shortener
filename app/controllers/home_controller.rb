# frozen_string_literal: true

class HomeController < ApplicationController
  def index
    @url = Url.new
  end
end
