class SessionsController < ApplicationController
    
    #action method login
    def login
        u = User.find_by_username(params[:username])
        if u && u.authenticate(params[:password])
            session[:userid] = u.id
            redirect_to apikey_path
        else
            flash[:danger] = 'Invalid Username or Password'
            redirect_to root_path
        end   
    end    
    
    
    
    #action method logout
    def logout

        logout
        flash[:success] = "Logged out!"
        redirect_to root_path

    end
end
