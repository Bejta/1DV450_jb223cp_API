module Api
 module V1
   class TagsController < ApibaseController
       respond_to :json
       
       def index 
           respond_with Tag.all , status: :ok
       end
       
       
       def tag_params
        json_params = ActionController::Parameters.new(JSON.parse(request.body.read))
        json_params.require(:tag).permit(:name)
       end
   end
 end
end