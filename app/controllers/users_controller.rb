class UsersController < ApplicationController
  before_action :find_user, only: [:show, :edit, :update, :destroy]
  before_action :require_admin!, except: [:edit, :update, :show]

  def index
    @users = User.all
  end

  def show
  end

  def new
    @user = User.new
  end


  def edit
    @user = current_user
  end

  def create
    @password= SecureRandom.hex[0,8]
    @user = User.new(:email=>params[:user][:email],:password=>@password,:first_name=>params[:user][:first_name],:last_name=>params[:user][:last_name])
      if @user.save
        UserMailer.welcome_email(@user,@password).deliver
        redirect_to "/users"
      else
        render "new"
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|

      if @user.update_with_password(user_params)
        sign_in @user, :bypass => true
        format.html { redirect_to edit_user_path(@user), notice: 'User was successfully updated.' }
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
    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params[:user].permit([:first_name, :last_name, :current_password, :password, :password_confirmation])
    end
end
