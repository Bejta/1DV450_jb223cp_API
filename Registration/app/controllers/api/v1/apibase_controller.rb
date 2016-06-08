module Api
 module V1
   class ApibaseController < ApplicationController
    
    #knock gem, authentication
    include Knock::Authenticable
    protect_from_forgery with: :null_session
    
    before_action :authenticate
    before_action :restricted_access
    
    respond_to :json
    
    #response if error
    COULD_NOT_PARSE_JSON = "Could not parse JSON"
    INVALID_TOKEN = "Invalid token"
    
    #offset and limit for bigger amount of data
    OFFSET = 0
    LIMIT =  8
    
    #check if token is correct and if there are offset and limit params in request
    private
    def restricted_access
          token = request.headers['token']
          app = App.where(token: token).first if token
          unless app
            render json: { error: INVALID_TOKEN}, status: :unauthorized
          end
    end
    
    def offset_params
        
      offset = params[:offset] if params[:offset].present?
      limit = params[:limit] if params[:limit].present?

      offset ||= OFFSET
      limit ||= LIMIT
    end
   end
 end
end