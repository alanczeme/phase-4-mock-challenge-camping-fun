class CampersController < ApplicationController
    rescue_from ActiveRecord::RecordNotFound, with: :render_not_found

    rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity_response

    def index
        render json: Camper.all
        # .to_json(only: [:id, :name, :age])
    end

    def show
        camper = Camper.find(params[:id])
        render json: camper, status: :ok, serializer: CamperActivitySerializer
    end

    def create
        camper = Camper.create!(camper_params)
        render json: camper, status: :created
    end

    private

    def camper_params
        params.permit(:name, :age)
    end

    def render_unprocessable_entity_response(invalid)
        render json: {errors: invalid.record.errors.full_messages}, status: :unprocessable_entity
    end

    def render_not_found
        render json: {error: "Camper not found"}, status: :not_found
    end
end
