module Api
 module V1
   class PositionsController < ApplicationController
        respond_to :json
       
       def index 
           respond_with Position.all, status: :ok
       end
   end
 end
end