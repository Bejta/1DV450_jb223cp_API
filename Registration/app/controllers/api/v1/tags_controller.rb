module Api
 module V1
   class TagsController < ApibaseController
       respond_to :json
       
       skip_before_action :authenticate, only: [:index, :show]
       before_action :offset_params, only: [:index]

       
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
       
       def create
          if params[:pub_id].nil?
            render json: { error: "There is no pub so that tag can be added to" } and return
          end
          
          pub = Pub.find_by_id(params[:pub_id])
          render json: { error: "There is no pub with id #{params[:pub_id]}" } and return unless pub.present?

          pub = Pub.find_by_id(params[:pub_id])
          
          
          begin
             if Tag.find_by(name: tag_params[:name])
               tag = Tag.find_by(name: tag_params[:name])
             else
               tag = Tag.new(tag_params)
             end
          if tag.save
             pub.tags << tag
             render json: tag, status: 201, location: [:api, tag]
          else
             render json: { errors: "Bad request" }, status: :bad_request
          end
          rescue JSON::ParserError => e
             render json: { error: "Could not parse JSON" }, status: :bad_request
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