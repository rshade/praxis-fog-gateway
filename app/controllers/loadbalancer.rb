  module V1
    class LoadBalancer
      include Praxis::Controller

      implements V1::ApiResources::LoadBalancer
      HELLO_WORLD=["not implemented"]

      def index(**params)
        response.headers['Content-Type'] = 'application/json'
        response.body = "Index Not Defined Yet"
        response
      end

      def show(id:, **other_params)
        hello = HELLO_WORLD[id]
        if hello
          response.body = { id: id, data: hello }
        else
          self.response = Praxis::Responses::NotFound.new
        end
        response.headers['Content-Type'] = 'application/json'
        response
      end

      def create(payload:)
        json_payload=JSON.parse(payload)
        config_hash=Praxis::Application.instance.config.clouds.contents
        current_cloud_config=config_hash[json_payload["cloud"]]
        lbs = Fog::LoadBalancer.new(current_cloud_config)
        lbs.load_balancers.create(json_payload["params"])
      end
    end
  end
