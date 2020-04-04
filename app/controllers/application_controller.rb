class ApplicationController < ActionController::Base
  include ApplicationHelper

  protect_from_forgery
  add_flash_types :success, :danger, :warning

  before_action :set_locale
  before_action :get_category

  def set_locale
    locale = params[:locale].to_s.strip.to_sym
    I18n.locale = I18n.available_locales.include?(locale) ?
    locale : I18n.default_locale
  end

  def default_url_options(options={})
    { locale: I18n.locale }
  end

  def get_category
    @categories = Category.select(:id, :name)
  end
end
