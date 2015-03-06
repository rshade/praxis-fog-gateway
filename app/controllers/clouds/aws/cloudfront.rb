module V1
  class Clouds
    class AWS
      class CloudFront
        include Praxis::Controller

        implements V1::ApiResources::Clouds::AWS::CloudFront

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
          cdn = Fog::CDN.new({ :provider => 'AWS' })
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

      end
    end
  end
end
