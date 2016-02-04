class ClientsController < ApplicationController
    
    #Check if user is logged in
    before_action :require_login
    
    def new
        @client = Client.new
    end
    
    
    def show
        @user = User.find_by(id: session[:userid])
    end 
    
    def index
    end
    
    def create
        
        
        @client = Client.new(client_params)
        @client.user_id = session[:userid]
        @client.apikey = generate_apikey
        

        if @client.save
          flash[:success] = "APIkey created"
          redirect_to client_path
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
    
    ### NEVER GOT IT TO WORK ###
    # about creating api key: https://bubblogging.wordpress.com/2014/01/10/ror-authentication-token/
    #def generate_apikey
    #  begin
    #    self.apikey = SecureRandom.hex
    #  end while self.class.exists?(apikey: apikey)
    #end
    def generate_apikey
    loop do
        token = SecureRandom.base64.tr('+/=', 'Qrt')
        break token
      end
    end
    
    private
    def client_params
        params.require(:client).permit(:name, :description, :url)
    end
end
