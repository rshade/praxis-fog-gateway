  module V1
    module ApiResources
      class LoadBalancer
        include Praxis::ResourceDefinition

        media_type V1::MediaTypes::LoadBalancer
        version '1.0'

        routing do
          prefix '/api/loadbalancer'
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
      end
    end
  end
