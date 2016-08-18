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
                 creator = Creator.find_by_name(params[:creator_name]);
                 pubs = creator.pubs unless creator.nil? 
                 
             # checks if address param is set
             elsif params[:address].present?
             # Important to pass the unit 
             # http://stackoverflow.com/questions/11463940/rails-geocoder-and-near
               location = Position.near(params[:address], 1,  units: :km)
               pubs = []
               
                  location.each do |loc|
                       if Pub.find_by_position_id(loc.id).present?
                         pubs.push(Pub.find_by_position_id(loc.id))
                       end
                  end
                 
             # checks if latitude and longitude param is set
             elsif params[:lat] && params[:lon]
             
             pubs = []
             #pubs.push(Pub.find_by_position_id(3))
             position = Position.near([params[:lat], params[:lon]], 1, units: :km)
               #puts params[:lat]
               #pubs = []
                  
                  position.each do |pos|
                     if Pub.find_by_position_id(pos.id).present?
                       pubs.push(Pub.find_by_position_id(pos.id))
                     end  
                  end
                  
             #checks if there is search criteria
             elsif params[:search]
               pubs = Pub.where("name like ? OR description like ?", "%#{params[:search]}%", "%#{params[:search]}%")
             
             #if there are no parameters set, return all pubs, sort by date created desc   
             else
               pubs = Pub.all.limit(@limit).offset(@offset)
             end
             
             if pubs.present?
                 
                pubs = pubs.drop(Integer(@offset))
                pubs = pubs.take(Integer(@limit))
                respond_with :api, pubs, status: :ok
               else
                 render json: { error: "There is no data for search criteria" }, status: :not_found
             end
       end
       
       
       #Update pub
       def update
        
        
        
        if pub = Pub.find_by_id(params[:id])
        #If user is not the same user that use application, then unauthorized is returned
        render json: { error: "You are not creator of this pub, and can not update it..." }, status: :unauthorized and return unless pub.creator_id = current_user.id
        
         begin
           if pub.update(pub_params)
             
             respond_with pub, status: 204
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
             pub = Pub.new(pub_params.except(:tags, :position))
              pub.creator_id = current_user.id
              
              if tags = pub_params[:tags]
              tags.each do |tag|
                pub.tags << Tag.where(tag).first_or_create
                end
              end
              
              if pub.save
                  
                  if Position.find_by(address: pub_params[:position][:address])
                    pub.position_id = Position.find_by(address: pub_params[:position][:address]).id
                  else
                    pub.position_id = Position.create(address: pub_params[:position][:address]).id
                  end
                 pub.creator.save
                 pub.position.save
                 
                respond_with pub, status: 201, location: [:api_v1, pub]
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