# frozen_string_literal: true

class HomeController < ApplicationController
  around_action :switch_locale

  def index; end

  def default_url_options
    { locale: I18n.locale }
  end
end
