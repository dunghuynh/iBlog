class ErrorController < ApplicationController
  def index
  end

  def not_found
    render :not_found, :layout => false
  end

end
