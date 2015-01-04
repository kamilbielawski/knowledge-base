module Api
  module V1
    class ResourcesController < ApiController
      before_action :find_topic, only: [:index, :create]
      before_action :find_resource, only: [:add_tag]

      def index
        @resources = @topic.resources.order(rating: :desc, updated_at: :desc)
        render 'index'
      end

      def create
        @resource = @topic.resources.create(resource_params)
        render '_show'
      end

      def add_tag
        if params[:tag].present?
          tag = Tag.find_or_create_by(name: params[:tag])
          @resource.tags << tag
        else
          render json: {message: "Missing parameter: 'tag'"}, status: 400
        end
      end

      private

      def find_topic
        if params[:id].present? && topic = Topic.find_by_id(params[:id])
          @topic = topic
        else
          render json: {message: 'Resource not found'}, status: 404
        end
      end

      def find_resource
        if params[:id].present? && resource = Resource.find_by_id(params[:id])
          @resource = resource
        else
          render json: {message: 'Resource not found'}, status: 404
        end
      end

      def resource_params
        params.require(:resource).permit(:name, :description, :url)
      end
    end
  end
end
