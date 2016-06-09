module Api
 module V1
    class CreatorsController < ApibaseController
       
       #methods index and show does not need authentication
       skip_before_action :authenticate, only: [:index, :show]
       
       #offset and limit parameters only on index
       before_action :offset_params, only: [:index]
       respond_to :json
       
       def index 
           respond_with Creator.offset(@offset).limit(@limit), status: :ok
       end
       
       #creator by id
       def show
        
       creator=Creator.find(params[:id])
         
         #Checks if there are creator with that id
         if creator.nil?
              render json: { errors: "No creator with id #{params[:id]} found.... "}, status: :not_found
          else
              respond_width json: creator, status: :ok
         end
       end
    end
 end
end