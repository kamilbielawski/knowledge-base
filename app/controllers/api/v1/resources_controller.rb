module Api
  module V1
    class ResourcesController < ApiController

      def index
        topic = Topic.find_by_id(params[:id])
        if topic
          @resources = topic.resources.order(updated_at: :desc)
          render 'index'
        else
          render json: {message: 'Resource not found'}, status: 404
        end
      end

      def create
        topic = Topic.find_by_id(params[:id])
        if topic
          @resource = topic.resources.create(resource_params)
            render '_show'
        else
          render json: {message: 'Resource not found'}, status: 404
        end
      end

      private

      def resource_params
        params.require(:resource).permit(:name, :description, :url)
      end
    end
  end
end
