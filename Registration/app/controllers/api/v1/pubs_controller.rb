module Api
 module V1
   class PubsController < ApibaseController
    
       #Authentication is not needed for index and show methods
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
               location = Position.near([params[:lat], params[:long]], 5)
               pub = []
                  location.each do |loc|
                     pub.push(Pub.find_by_id(position.pub_id))
                  end
                  
             #checks if there is search criteria
             elsif params[:search]
               pubs = Pub.where("name like ? OR description like ?", "%#{params[:search]}%", "%#{params[:search]}%")
             
             #if there are no parameters set, return all pubs, sort by date created desc   
             else
               pubs = Pub.all.limit(limit).offset(offset).order("created_at DESC")
             end
             
             if pubs.present?
                respond_with pubs.limit(limit).offset(limit)
               else
                 render json: { error: "There is no data for search criteria" }, status: :not_found
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
         json_params.require(:pub).permit(:name, :description, tags: [:name], positions: [:address])
       end
   end
 end
end 