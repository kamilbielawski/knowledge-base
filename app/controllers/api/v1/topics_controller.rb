module Api
  module V1
    class TopicsController < ApiController

      def index
        if params[:keywords]
          @topics = Topic.where('name ilike ?', "%#{params[:keywords]}%")
        else
          @topics = []
        end
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
