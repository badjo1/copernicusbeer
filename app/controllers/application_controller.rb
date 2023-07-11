class ApplicationController < ActionController::Base

	protected

    Breadcrumb = Struct.new(:name, :path)

    def add_breadcrumb(name, path = nil)
      self.breadcrumbs << Breadcrumb.new(name, path)
    end

    def breadcrumbs
      @breadcrumbs ||= []
    end
end
