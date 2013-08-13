class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_filter :configure_permitted_parameters, if: :devise_controller?
  before_filter :authenticate_user!
  before_filter :fetch_required_items

  def fetch_required_items
    if current_user && !request.xhr? # && request.get?
      @system_setting = SystemSetting.find_by_name("cache")
      @categories = Rails.cache.fetch("dbCat#{@system_setting.value['category']}", expires_in: 1.week) {
        Category.select("id, name").to_a
      }
      @sub_categories = Rails.cache.fetch("dbSubCat#{@system_setting.value['sub_category']}", expires_in: 1.week) {
        SubCategory.select("id, name, category_id").group_by(&:category_id)
      }
    end
  end

  def require_admin!
    unless current_user && current_user.is_admin
      flash[:alert] = "Access denied"
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

  %w(user category sub_category post comment).each do |name|
    define_method "find_#{name}" do
      obj = instance_variable_set("@#{name}", name.camelize.constantize.find_by_id(params[:id]))
      unless obj
        respond_to do |format|
          format.html{
            flash[:alert] = "#{name.camelize} not found"
            redirect_to "/#{name.pluralize}"
          }
          format.js{
            render js: "displayFlash('#{name.camelize} not found', 'alert-error');"
          }
        end
      end
    end
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_in) { |u| u.permit(:email) }
  end
end
