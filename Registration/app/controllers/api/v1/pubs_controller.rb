module Api
 module V1
   class PubsController < ApibaseController
    
       #Authentication is not needed for index and show methods
       skip_before_action :authenticate, only: [:index, :show]
       #Eventual offset parameters are only applicable on index method
       before_action :offset_params, only: [:index]
       
       
       respond_to :json
       
       def index 
           respond_with Pub.all, status: :ok
       end
       
       def show
          respond_with Pub.find(params[:id])
       end
   end       
 end
end 