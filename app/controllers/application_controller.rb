class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_filter :configure_permitted_parameters, if: :devise_controller?
  before_filter :authenticate_user!

  def require_admin
    unless current_user || current_user.is_admin
      respond_to do |format|
        format.html {
          redirect_to "/"
        }
        format.js {
          render js: "window.location='/'"
        }
      end
    end
  end

  def after_sign_in_path_for(resource)
    "/posts"
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_in) { |u| u.permit(:email) }
  end
end
