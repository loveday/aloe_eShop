# Copyright Notice
# We do not hold full Copyright to the codes
# The codes in this App is a combination of code snippets from
# NCI Class Tutorials and the  {Agile Web Development with Rails}
#[http://www.pragprog.com/titles/rails4/agile-web-development-with-rails-4th-edition].
class SessionsController < ApplicationController
 # skip_before_filter :authorize

  def new
  end

  def create
    user = User.authenticate(params[:name], params[:password])
      if user
      session[:user_id] = user.id
      #redirect_to admin_url
     redirect_to store_path, :notice => "Logged in successfully"
    else
      redirect_to login_url, alert: "Invalid user/password combination"
#      flash.now[:alert] = "Invalid login/password combination"
#      render :action => 'new'
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to store_url, notice: "You successfully Logged out"
#    reset_session
#    redirect_to store_path, :notice => "You successfully logged out"
  end
end
