class ApplicationController < ActionController::Base
  protect_from_forgery

  protected
    def record_not_found
      flash[:error] = 'The resource you requested could not be found.'
      redirect_to error_404_url
    end
end
