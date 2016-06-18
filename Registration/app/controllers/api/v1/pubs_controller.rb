module Api
 module V1
   class PubsController < ApibaseController
    
       #Authorization is not needed for index and show methods
       skip_before_action :authenticate, only: [:index, :show]
       #Eventual offset parameters are only applicable on index method
       before_action :offset_params, only: [:index]
       
       #default values
       DISTANCE = 1
       
       respond_to :json
       
       def index 
           # checks if tag_id param is set
             if params[:tag_id].present?
                tag = Tag.find_by_id(params[:tag_id])
                pubs = tag.pubs unless tag.nil?
                
             # checks if creator_id param is set
             elsif params[:creator_id].present?
                 creator = Creator.find_by_id(params[:creator_id])
                 pubs = creator.pubs unless creator.nil?
                 
             #checks if name of creator is set as param    
             elsif params[:name]
                 creator = Creator.find_by_name(params[:name]);
                 pubs = creator.pubs unless creator.nil? 
                 
             # checks if address param is set
             elsif params[:address].present?
               location = Position.near(params[:address], 5)
               pubs = []
                  location.each do |loc|
                     pub.push(Pub.find_by_id(location.pub_id))
                  end
                 
             # checks if latitude and longitude param is set
             elsif params[:latitude] && params[:longitude]
               location = Position.near([params[:latitude], params[:longitude]], 5)
               pub = []
                  location.each do |loc|
                     pub.push(Pub.find_by_id(position.pub_id))
                  end
                  
             #checks if there is search criteria
             elsif params[:search]
               pubs = Pub.where("name like ? OR description like ?", "%#{params[:search]}%", "%#{params[:search]}%")
             
             #if there are no parameters set, return all pubs, sort by date created desc   
             else
               pubs = Pub.all.limit(@limit).offset(@offset)
             end
             
             if pubs.present?
                respond_with pubs.limit(@limit).offset(@offset)
               else
                 render json: { error: "There is no data for search criteria" }, status: :not_found
             end
       end
       
       
       #Update pub
       def update
        
        #If user is not the same user that use application, then unauthorized is returned
        render json: { error: "You are not creator of this pub, and can not update it..." }, status: :unauthorized and return unless pub.creator_id = current_user.id
        
        if pub = Pub.find_by_id(params[:id])
         begin
           if pub.update(pub_params)
             render json: { action: "update", pub: PubSerializer.new(pub) }, status: :ok
           else
             render json: { errors: "Bad request"}, status: :bad_request
           end
         rescue JSON::ParserError => e
           render json: { error: "Could not parse JSON ..."}, status: :bad_request
         end
         else
            render json: { errors: "Pub with id #{params[:id]} not found! " }, status: :not_found
        end
       end
       
       #Create pub
       def create
        begin
           return unless pub_params[:position].present?
              pub = Pub.new(pub_params.except(:tags, :positions))
              pub.creator_id = current_user.id
              
              if tags = pub_params[:tags]
              tags.each do |tag|
                pub.tags << Tag.where(tag).first_or_create
                end
              end
              
              if pub.save
                 
                 pub.position=Position.create(address: pos['address'], pub_id: pub.id)
                 pub.creator.save
                 pub.position.save
                 
                 respond_with :api, pub, status: :created
              else
                 render json: { errors: "Could not save a pub..." }, status: :bad_request
              end
        rescue JSON::ParserError => e
           render json: { error: "Could not parse JSON..."}, status: :bad_request
        end
       end
       
       #Shows one pub, with id from parameter
       def show
         pub = Pub.find(params[:id])
         if pub.present?
           respond_with pub, status: :ok
         else
           render json: { error: "There is no pub with id: #{params[:id]}" }, status: :not_found
         end
       end
       
       #Delete one pub (must be a member)
       def destroy
         if pub = Pub.find_by_id(params[:id])
             pub.destroy
             render json: { action: "destroy", message: "Pub removed...", status: :ok}
         else
             render json: { errors: "pub with an id #{params[:id]} not found! " }, status: :not_found
         end
       end 
       
       
       def pub_params
         json_params = ActionController::Parameters.new(JSON.parse(request.body.read))
         json_params.require(:pub).permit(:name, :description, :rating, tags: [:name], position: [:address])
       end
   end
 end
end 