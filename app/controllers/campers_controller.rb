class CampersController < ApplicationController
    rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response
    def index
        campers = Camper.all
        render json: campers, status: :ok
    end
    def show
        camper= Camper.find(params[:id])
        render json: camper, each_serializer: CamperActivitiesSerializer
    end
    def create
        camper= Camper.create(camper_params)
        if camper.valid?
        render json: camper, status: :created
          else
            render json: {errors: camper.errors.full_messages}, status: :unprocessable_entity
        end
    end  
    private  
    def camper_params
        params.permit(:name, :age)
      end
  
      def render_not_found_response
          render json: { error: "Camper not found" }, status: :not_found
      end
end
