module V1
  class LoadBalancer
    include Praxis::Controller

    implements V1::ApiResources::Clouds::AWS::ELB

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
      json_payload=JSON.parse(payload)
      lbs = Fog::LoadBalancer[json_payload["cloud"]]
      lbs.load_balancers.create(json_payload["params"])
    end

    def connect()
      payload=request.payload.contents
      Praxis::Application.instance.logger.error payload
      response.headers['Content-Type'] = 'application/json'
      lb=Fog::AWS::ELB.new
      connect=lb.register_instances_with_load_balancer([payload[:node]],payload[:loadbalancer])
      response.body = connect.data[:body].to_json
      response.status = connect.status
      response
    end
    
    def disconnect(cloud:)
      payload=request.payload.contents
      Praxis::Application.instance.logger.error payload
      response.headers['Content-Type'] = 'application/json'
      lb=Fog::AWS::ELB.new
      connect=lb.deregister_instances_from_load_balancer([payload[:node]],payload[:loadbalancer])
      response.body = connect.data[:body].to_json
      response.status = connect.status
      response
    end
  end
end