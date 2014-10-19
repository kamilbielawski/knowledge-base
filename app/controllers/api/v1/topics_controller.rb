module Api
  module V1
    class TopicsController < ApiController

      def index
        @topics = Topic.all
        render 'index'
      end
    end
  end
end
