  module V1
    module ApiResources
      class Log
        include Praxis::ResourceDefinition

        media_type V1::MediaTypes::Log
        version '1.0'

        routing do
          prefix '/api/log'
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
            attribute :message, String,
              required: true
          end
          response :ok
          response :created
        end
      end
    end
  end
