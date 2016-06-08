module Api
 module V1
   class TagsController < ApibaseController
       respond_to :json
       
       def index 
         if (params[:pub_id])
            pub = Pub.find_by_id(params[:pub_id])
            if pub.present?
              tags =  pub.tags
            else
            render json: { error: "Could not found pub with id #{params[:pub_id]}" }, status: :not_found and return
            end
         else
            tags = Tag.all
         end
           respond_with tags, status: :ok
       end
       
       def show
        
        tag = Tag.find_by_id(params[:id])
        if tag.present?
          respond_with tag, status: :ok
        else
          render json: { error: "Could not find tag with id of #{params[:id]}" }, status: :not_found
        end
       end
       
       
       
     private  
       def tag_params
        json_params = ActionController::Parameters.new(JSON.parse(request.body.read))
        json_params.require(:tag).permit(:name)
       end
   end
 end
end