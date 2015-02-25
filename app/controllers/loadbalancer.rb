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
        binding.pry
        json_payload=JSON.parse(payload)
        lbs = Fog::LoadBalancer[json_payload["cloud"]]
        lbs.load_balancers.create(json_payload["params"])
      end
    end
  end
