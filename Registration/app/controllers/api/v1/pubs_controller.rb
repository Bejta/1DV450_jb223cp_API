module Api
 module V1
   class PubsController < ApplicationController
       
       respond_to :json
       
       def index 
           respond_with Pub.all
       end
       
       def show
          respond_with Pub.find(params[:id])
       end
   end       
 end
end 