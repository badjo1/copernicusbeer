class ApplicationController < ActionController::Base
  include UserSessionsHelper
  before_action :set_locale
 
	protected

    Breadcrumb = Struct.new(:name, :path)

    def add_breadcrumb(name, path = nil)
      self.breadcrumbs << Breadcrumb.new(name, path)
    end

    def breadcrumbs
      @breadcrumbs ||= []
    end

    def set_locale
      I18n.locale = params[:locale] || I18n.default_locale
    end
end


  
