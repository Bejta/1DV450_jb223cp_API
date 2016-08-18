module Api
 module V1
   class ApibaseController < ApplicationController
    
    #knock gem, authentication
    include Knock::Authenticable
    protect_from_forgery with: :null_session
    
    after_filter :cors_set_access_control_headers
    def route_options
      cors_preflight_check
    end
    
    def cors_set_access_control_headers
    response.headers['Access-Control-Allow-Origin'] = '*'
    response.headers['Access-Control-Allow-Methods'] = 'POST, GET, PUT, PATCH, DELETE, OPTIONS'
    response.headers['Access-Control-Allow-Headers'] = 'Origin, Content-Type, Accept, Authorization, Token, Auth-Token, Email'
    response.headers['Access-Control-Max-Age'] = "1728000"
    end

    def cors_preflight_check
        if request.method == 'OPTIONS'
          request.headers['Access-Control-Allow-Origin'] = '*'
          request.headers['Access-Control-Allow-Methods'] = 'POST, GET, PUT, PATCH, DELETE, OPTIONS'
          request.headers['Access-Control-Allow-Headers'] = 'X-Requested-With, X-Prototype-Version, Token, Auth-Token, Email'
          request.headers['Access-Control-Max-Age'] = '1728000'  
          render :text => '', :content_type => 'text/plain'
        end
    end
    
    before_action :authenticate
    before_action :key_access
    
    respond_to :json
    
    #response if error
    COULD_NOT_PARSE_JSON = "Could not parse JSON"
    INVALID_APIKEY = "Invalid API Key"
    
    #offset and limit for bigger amount of data
    OFFSET = 0
    LIMIT =  15
    
    #check if token is correct and if there are offset and limit params in request
    private
    def key_access
          #token = request.headers['token']
          #also checks if token is active
          
          @client = Client.where(apikey: params[:akey]).where(active: true).first
          unless @client
            render json: { error: INVALID_APIKEY}, status: :unauthorized
          end
    end
    
    def offset_params
        
      @offset = params[:offset] if params[:offset].present?
      @limit = params[:limit] if params[:limit].present?

      @offset ||= OFFSET
      @limit ||= LIMIT
    end
   end
 end
end