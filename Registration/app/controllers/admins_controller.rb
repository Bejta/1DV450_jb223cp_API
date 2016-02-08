class AdminsController < ApplicationController
    #before_action :require_login
    before_action :is_admin
    
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
    
    #Activate/deactivate application
    def revoke
        @client = Client.find(params[:id])
        if @client.active
            @client.active = false
            flash[:success] = 'Application deactivated'
        else
            @client.active = true
            flash[:success] = 'Application activated'
        end    
        @client.save
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
