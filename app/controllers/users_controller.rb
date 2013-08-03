class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  #authorize! :create, current_user, :message => 'Not authorized as an administrator'

  def index
    @users = User.all
    logger.info "##########################{@users.inspect}"
  end

  def show
  end

  def new
    #params[:user].permit!
    @user = User.new
  end


  def edit
  end

  def create
    @password= SecureRandom.hex[0,8]
    @user = User.new(:email=>params[:user][:email],:password=>@password)
      if @user.save
        UserMailer.welcome_email(params[:user][:email],@password).deliver
        redirect_to "/users"
      else
        redirect_to "/users/new"
        #format.json { render json: @user.errors, status: :unprocessable_entity }
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params[:user].permit!
    end
end
