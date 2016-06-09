module Api
 module V1
   class PositionsController < ApibaseController
        respond_to :json
        skip_before_action :authenticate, only: [:index, :show]
        before_action :offset_params, only: [:index]
       
       def index 
           respond_with Position.limit(@limit).offset(@offset), status: :ok
       end

       def show
           respond_with Position.find(params[:id]), status: :ok
       end
   end
 end
end