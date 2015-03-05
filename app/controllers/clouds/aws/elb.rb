module V1
  class Clouds
    class AWS
      class ELB
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
          payload = request.payload.contents
          lb = Fog::AWS::ELB.new(:region=> payload[:region])
          response.headers['Content-Type'] = 'application/json'
          create = lb.create_load_balancer(payload[:zones],payload[:name],payload[:listeners])
          response.body = create.data[:body].to_json
          response.status = create.status
          response
        end

        def delete()
          payload = request.payload.contents
          lb = Fog::AWS::ELB.new(:region=> payload[:region])
          response.headers['Content-Type'] = 'application/json'
          delete = lb.delete_load_balancer(payload[:name])
          response.body = delete.data[:body].to_json
          response.status = delete.status
          response
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

        def disconnect()
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
  end
end
