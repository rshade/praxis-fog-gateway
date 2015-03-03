module V1
  module ApiResources
    class Clouds
      class RackSpace
        class CLB
          include Praxis::ResourceDefinition

          media_type V1::MediaTypes::Clouds::RackSpace::CLB
          version '1.0'

          routing do
            prefix '/api/clouds/rackspace/clb'
          end

          action :index do
            use :versionable

            routing do
              get ''
            end
            response :ok
          end

          action :show do
            use :versionable

            routing do
              get '/:id'
            end
            params do
              attribute :id, Integer, required: true, min: 0
            end
            response :ok
            response :not_found
          end

          action :create do
            use :versionable

            routing do
              post '/create'
            end

            params do
              attribute :name, String, required: true
            end

            response :ok
            response :created
          end

          action :connect do
            use :versionable

            routing do
              post "/connect"
            end

            params do
              attribute :cloud, String, required: true
            end

            payload do
              attribute :node, String, required: true
              attribute :loadbalancer, String, required: true
            end

            response :ok
          end
          action :disconnect do
            use :versionable

            routing do
              post "/disconnect"
            end

            params do
              attribute :cloud, String, required: true
            end

            payload do
              attribute :node, String, required: true
              attribute :loadbalancer, String, required: true
            end

            response :ok
          end
        end
      end
    end
  end
end

