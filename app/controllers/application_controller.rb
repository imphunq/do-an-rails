class ApplicationController < ActionController::Base
  include ApplicationHelper

  protect_from_forgery
  add_flash_types :success, :danger, :warning

  before_action :set_locale
  before_action :get_category
  before_action :get_author

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

  def get_author
    @authors = Author.select :id, :name
  end

  protected
  def authenticate_user!
    if user_signed_in?
      super
    else
      redirect_to signin_path, :warning => 'if you want to add a notice'
      ## if you want render 404 page
      ## render :file => File.join(Rails.root, 'public/404'), :formats => [:html], :status => 404, :layout => false
    end
  end
end
