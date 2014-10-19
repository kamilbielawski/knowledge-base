module Api
  module V1
    class TopicsController < ApiController

      def index
        @topics = Topic.all
        render 'index'
      end

      def destroy
        @topic = Topic.find_by_id(params[:id])
        if @topic
          @topic.delete
          render '_show'
        else
          render json: {message: 'Resource not found'}, status: 404
        end
      end
    end
  end
end
