module Api
 module V1
    class CreatorsController < ApibaseController
       
       #methods index and show does not need authentication
       skip_before_action :authenticate, only: [:index, :show]
       
       #offset and limit parameters only on index
       before_action :offset_params, only: [:index]
       respond_to :json
       
       def index 
         if params[:id].present?
                creator = Creator.find_by_id(params[:id])
                #pubs = tag.pubs unless tag.nil?
                
             # checks if creator_id param is set
         elsif params[:name].present?
                 creator = Creator.find_by_name(params[:name])
                 #pubs = creator.pubs unless creator.nil?
           #respond_with Creator.offset(@offset).limit(@limit), status: :ok
         else
               creator = Creator.all.limit(@limit).offset(@offset)
         end
        
         if creator.nil?
              render json: { errors: "No creator with id #{params[:id]} found.... "}, status: :not_found
         else
             respond_with :api, creator, status: :ok
         end
         #respond_with Creator.offset(@offset).limit(@limit), status: :ok
       end  
       
       #creator by id or name
       def show
        
         
       end  
       
       def creator_params
         json_params = ActionController::Parameters.new(JSON.parse(request.body.read))
         json_params.require(:creator).permit(:name, :id)
       end
    end     
 end      
end