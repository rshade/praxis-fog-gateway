module V1
  class Clouds
    class RackSpace
      include Praxis::Controller
      implements V1::ApiResources::Clouds::RackSpace

      AVAILABLE_METHODS=["elb"]
      def index(**params)
        response.headers['Content-Type'] = 'application/json'
        response.body = AVAILABLE_METHODS.to_json
        response
      end
    end
  end
end
