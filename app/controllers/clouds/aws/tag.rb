module V1
  class Clouds
    class AWS
      class Tag
        include Praxis::Controller

        implements V1::ApiResources::Clouds::AWS::Tag

        def index(region:, **params)
          response.headers['Content-Type'] = 'application/json'
          fog = Fog::Compute.new({
            :provider => 'AWS',
            :region => region
          })
          response.body = fog.describe_tags.data[:body].to_json
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
          create = fog.create_tags(payload[:resource_id],payload[:tags])
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
          delete = fog.delete_tags(payload[:resource_id],payload[:tags])
          response.body = delete.data[:body].to_json
          response.status = delete.status
          response
        end
      end
    end
  end
end
