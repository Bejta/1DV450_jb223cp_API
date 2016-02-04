class AdminsController < ApplicationController
    before_action :require_login
    
    def show
      @user = User.all
    end
    
    #Delete User
    def destroy
        @user2 = User.find(params[:id])
        @user2.destroy
        flash[:success] = 'User deleted!'
        redirect_to admin_path
    end
    
    #Delete application
    def delete
        @client = Client.find(params[:id])
        @client.destroy
        flash[:success] = 'Application deleted!'
        redirect_to admin_path
    end
end
