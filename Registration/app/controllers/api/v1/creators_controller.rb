module Api
 module V1
    class CreatorsController < ApibaseController
       
       #methods index and show does not need authentication
       skip_before_action :authenticate, only: [:index, :show]
       
       #offset and limit parameters only on index
       before_action :offset_params, only: [:index]
       respond_to :json
       
       def index 
           respond_with Creator.offset(offset).limit(limit), status: :ok
       end
       
       #creator by id
       def show
           respond_with Creator.find(params[:id])
       end
     
    end
 end
end