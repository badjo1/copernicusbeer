class ProtectedController < ApplicationController
  before_action :require_login
  
  class NotAuthorizedError < StandardError
    attr_reader :exception_type
    def initialize(msg="not_authorized", exception_type="error")
      @exception_type = exception_type
      super(msg)
    end
  end
  rescue_from NotAuthorizedError, with: :not_authorized
 
  protected

    def not_authorized(exception)
      flash[:warning] = t "#{exception.exception_type}.#{exception.message}", scope: "pundit", default: :defaultt
      redirect_to(request.referrer || root_path)
    end
  
    def not_authenticated
      redirect_to login_path, alert: "Please connect your wallet"
    end

  private

    def require_login
      not_authenticated unless logged_in?
    end

end