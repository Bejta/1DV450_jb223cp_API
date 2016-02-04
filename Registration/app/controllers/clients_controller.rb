class ClientsController < ApplicationController
    
    def new
        @client = Client.new
    end
    
    
    
    
    
    def show
    end 
    
    def index
    end
    
    def create
        
        
        @client = Client.new(client_params)
        
        

        if @apikey.save
          flash[:success] = "APIkey created"
          redirect_to apikeys_path
        else
          render :action => 'new'
        end
    end
    
    #Delete application
    def delete
        @client = Client.find(params[:id])
        @client.destroy
        flash[:success] = 'Application deleted!'
        redirect_to client_path
    end
    
    
    def generate_access_token
      begin
        self.access_token = SecureRandom.hex
      end while self.class.exists?(access_token: access_token)
    end
    
    private
    def client_params
        params.require(:client).permit(:name, :description, :url)
    end
end
