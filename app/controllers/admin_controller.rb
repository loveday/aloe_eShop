# Copyright Notice

# We do not hold full Copyright to the codes
# The codes in this App is a combination of code snippets from
# NCI Class Tutorials and the  {Agile Web Development with Rails}
# [http://www.pragprog.com/titles/rails4/agile-web-development-with-rails-4th-edition].
class AdminController < ApplicationController

  # Make the Order Count Available to the Admin
  def index
    @total_orders = Order.count
  end

  # We just display the form and wait for user to
  # enter a name and password
  def login
    if request.post?
      user = User.authenticate(params[:name], params[:password])
      if user
        session[:user_id] = user.id
        redirect_to(:action => "index")
      else
        flash.now[:notice] = "Invalid user/password combination"
      end
    end
  end

  def logout
    session[:user_id] = nil
    flash[:notice] = "Logged out"
    redirect_to(:action => "login")
  end

end
