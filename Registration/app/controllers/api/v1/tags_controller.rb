module Api
 module V1
   class TagsController < ApibaseController
       respond_to :json
       
       def index 
           respond_with Tag.all , status: :ok
       end
   end
 end
end