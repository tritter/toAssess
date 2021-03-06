class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :authenticate_user!

  rescue_from CanCan::AccessDenied do |exception|
    flash[:error] = 'Geen toegang.'
    redirect_to root_url
  end

  private
  # Overwriting the sign_out redirect path method
  def after_sign_out_path_for(resource_or_scope)
    #new_user_session_path
    send("new_#{resource_or_scope}_session_path")
  end

  #def stored_location_for
  #  nil
  #end
end
