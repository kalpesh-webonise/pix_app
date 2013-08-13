class UsersController < ApplicationController
  before_action :find_user, only: [:destroy]
  before_action :require_admin!, except: [:edit, :update]

  def index
    @users = User.where("is_admin = ?", false).page(params[:page]).per(10)
    respond_to do |format|
      format.html
      format.js
    end
  end

  def new
    @user = User.new
  end

  def create
    password = SecureRandom.hex[0,8]
    @user = User.new new_user_params
    @user.password, @user.tmp_password = password, password
    if @user.save
      flash[:notice] = "User created successfully!"
      redirect_to "/users"
    else
      render "new"
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      if current_user.update_with_password(user_params)
        sign_in current_user, :bypass => true
        format.html { redirect_to edit_user_path(current_user), notice: 'User was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: current_user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    if !@user.is_admin && @user.destroy
      flash[:notice] = "User deleted successfully"
    else
      flash[:alert] = "Unable to delete user"
    end
  end


  private
    # Never trust parameters from the scary internet, only allow the white list through.
    def new_user_params
      params[:user].permit(:first_name, :last_name, :email)
    end

    def user_params
      params[:user].permit(:first_name, :last_name, :current_password, :password, :password_confirmation)
    end
end
