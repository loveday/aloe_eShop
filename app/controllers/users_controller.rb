# Copyright Notice
# We do not hold full Copyright to the codes
# The codes in this App is a combination of code snippets from
# NCI Class Tutorials and the  {Agile Web Development with Rails}
#[http://www.pragprog.com/titles/rails4/agile-web-development-with-rails-4th-edition].
class UsersController < ApplicationController

  #before_filter :authorize, :except => [:create]
  # GET /users
  # GET /users.xml
  def index
    # Display and sort Users by Name
    @users = User.order (:name)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @users }
    end
  end

  # GET /users/1
  # GET /users/1.xml
  def show
    @user = User.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @user }
    end
  end

  # GET /users/new
  # GET /users/new.xml
  def new
    @user = User.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @user }
    end
  end

  # GET /users/1/edit
  def edit
    @user = User.find(params[:id])
  end

  # POST /users
  # POST /users.xml
  def create
    @user = User.new(params[:user])

    respond_to do |format|
      if @user.save
        #Avoid redirect after User is created or updated
        format.html { redirect_to(users_url,
          :notice => "User #{@user.name} was successfully created.") }
        format.xml  { render :xml => @user, :status => :created,
                             :location => @user }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @user.errors,
                             :status => :unprocessable_entity }
      end
    end
  end

  # PUT /users/1
  # PUT /users/1.xml
  def update
    @user = User.find(params[:id])

    respond_to do |format|
      if @user.update_attributes(params[:user])
        format.html { redirect_to(users_url,
         :notice => "User #{@user.name} was successfully updated.") }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @user.errors,
                             :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.xml
  def destroy
    @user = User.find(params[:id])
    begin
      @user.destroy
      flash[:notice] = "User #{@user.name} deleted"
    rescue Exception => e
      flash[:notice] = e.message
    end
    respond_to do |format|
      format.html { redirect_to(users_url) }
      format.xml  { head :ok }
    end
  end

 # def index
 #   @users = User.find(:all)
#  end

 # def new
 #   @user = User.new
#  end

 # def create
 #   @user = User.new(params[:user])
 #   if @user.save
#      redirect_to products_path, :notice => 'User creation successful!'
#    else
#      render :action => 'new'
#    end
 # end
end
