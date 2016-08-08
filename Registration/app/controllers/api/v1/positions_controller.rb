module Api
 module V1
   class PositionsController < ApibaseController
        respond_to :json
        skip_before_action :authenticate, only: [:index, :show]
        before_action :offset_params, only: [:index]
       
       def index 
           respond_with Position.limit(@limit).offset(@offset), status: :ok
       end
       
       #Creates new location
       def create
        location = Position.new(pos_params)
        if Position.where(address: location.address).present?
            render json: { errors: "Location already exsists" }, status: :conflict
        else
            if location.save
                respond_with :api, location, status: :created
            else
                render json: { errors: location.errors.messages }, status: :bad_request
            end
        end
       end

       def show
           respond_with Position.find(params[:id]), status: :ok
       end
   end
 end
end