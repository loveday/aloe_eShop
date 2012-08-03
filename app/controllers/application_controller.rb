# Copyright Notice
# We do not hold full Copyright to the codes
# The codes in this App is a combination of code snippets from
# NCI Class Tutorials and the  {Agile Web Development with Rails}
#[http://www.pragprog.com/titles/rails4/agile-web-development-with-rails-4th-edition].
class ApplicationController < ActionController::Base
  #before_filter :authorize    #Requires authorization before any/every access to the App

  protect_from_forgery

  protected
                              # Limiting User Access
  def authorize
    if request.format == Mime::HTML
      unless User.find_by_id(session[:user_id])
        redirect_to login_url, notice: "Please log in"
      end
    else
      authenticate_or_request_with_http_basic do |username, password|
        user = User.authenticate(username, password)
      end
    end
  end

# Returns the currently logged in user or nil if there isn't one
  def current_user
    return unless session[:user_id]
    @current_user ||= User.find_by_id(session[:user_id])
  end

# Make current_user available in templates as a helper
  helper_method :current_user

# Filter method to enforce a login requirement
# Apply as a before_filter on any controller you want to protect
  def authenticate
    logged_in? ? true : access_denied
  end

# Predicate method to test for a logged in user
  def logged_in?
    current_user.is_a? User
  end

# Make logged_in? available in templates as a helper
  helper_method :logged_in?
  def access_denied
    redirect_to login_path, :notice => "Please log in to continue" and return false
  end


  private
  def current_cart
    Cart.find(session[:cart_id])
  rescue ActiveRecord::RecordNotFound
    cart = Cart.create
    session[:cart_id] = cart.id
    cart
  end

end
