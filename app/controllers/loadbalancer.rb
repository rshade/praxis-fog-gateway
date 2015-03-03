  module V1
    class LoadBalancer
      include Praxis::Controller

      implements V1::ApiResources::LoadBalancer

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

      def create()
        binding.pry
        json_payload=JSON.parse(payload)
        lbs = Fog::LoadBalancer[json_payload["cloud"]]
        lbs.load_balancers.create(json_payload["params"])
      end

      def connect(cloud:)
        payload=request.payload.contents
        Praxis::Application.instance.logger.error payload
        response.headers['Content-Type'] = 'application/json'
        case cloud.downcase
        when "aws"
          lb=Fog::AWS::ELB.new
          connect=lb.register_instances_with_load_balancer([payload[:node]],payload[:loadbalancer])
          response.body = connect.data[:body].to_json
          response.status = connect.status
        end
        response
      end
      def disconnect(cloud:)
        payload=request.payload.contents
        Praxis::Application.instance.logger.error payload
        response.headers['Content-Type'] = 'application/json'
        case cloud.downcase
        when "aws"
          lb=Fog::AWS::ELB.new
          connect=lb.deregister_instances_from_load_balancer([payload[:node]],payload[:loadbalancer])
          response.body = connect.data[:body].to_json
          response.status = connect.status
        end
        response
      end
    end
  end
