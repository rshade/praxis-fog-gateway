module V1
  class Clouds
    class AWS
      class Tag
        include Praxis::Controller

        implements V1::ApiResources::Clouds::AWS::Tag

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
          fog = Fog::Compute.new({
            :provider => 'AWS',
            :region => payload[:region]
          })
          response.headers['Content-Type'] = 'application/json'
          create = fog.tags.create(payload[:resource_id],payload[:key],payload[:value])
          response.body = create.data[:body].to_json
          response.status = create.status
          response
        end

        def delete()
          payload = request.payload.contents
          fog = Fog::Compute.new({
            :provider => 'AWS',
            :region => payload[:region]
          })
          response.headers['Content-Type'] = 'application/json'
          delete = fog.tags.delete(payload[:resource_id],payload[:key])
          response.body = delete.data[:body].to_json
          response.status = delete.status
          response
        end
      end
    end
  end
end
