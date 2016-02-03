class UsersController < ApplicationController

  def new
    @user = User.new
  end
  
  def create
    #calls the private method user_params
    #example from demo video
    @user = User.new(user_params)

    if @user.save
      log_in @user
    else
      render :action => 'new'
    end
  end
  
  private
  def user_params
      params.require(:user).permit(:username, :email, :password, :password_confirmation)
  end
end
