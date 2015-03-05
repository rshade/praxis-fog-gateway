module V1
  module ApiResources
    class Clouds
      class AWS
        class ELB
          include Praxis::ResourceDefinition

          media_type V1::MediaTypes::Clouds::AWS::ELB
          version '1.0'

          routing do
            prefix '/api/clouds/aws/elb'
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
              post ''
            end

            payload do
              attribute :name, String,
                required: true,
                description: 'Name of ELB to create'
              attribute :region, String,
                required: true,
                description: 'Region to create ELB in'
              attribute :zones, Attributor::Collection,
                required: true,
                description: 'Zones you want lb to listen in'
              attribute :listeners, Attributor::Collection,
                required: true,
                description: 'Array of hashes containing listeners'
            end

            response :ok
            response :created
          end

          action :delete do
            use :versionable

            routing do
              delete ''
            end

            payload do
              attribute :name, String,
                required: true,
                description: 'Name of ELB to delete'
              attribute :region, String,
                required: true,
                description: 'Region ELB is in'
            end
            response :no_content
            response :ok
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

