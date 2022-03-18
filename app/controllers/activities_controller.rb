class ActivitiesController < ApplicationController
    rescue_from ActiveRecord::RecordNotFound, with: :render_not_found

    def index
        render json: Activity.all, status: :ok
    end

    def destroy
        Activity.find(params[:id]).destroy
        render json: {}, status: :ok
    end

    private

    def render_not_found
        render json: {error: "Activity not found"}, status: :not_found
    end

end
