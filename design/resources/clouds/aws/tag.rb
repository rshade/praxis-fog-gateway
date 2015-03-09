module V1
  module ApiResources
    class Clouds
      class AWS
        class Tag
          include Praxis::ResourceDefinition

          media_type V1::MediaTypes::Clouds::AWS::Tag
          version '1.0'

          routing do
            prefix '/api/clouds/aws/tag'
          end

          action :index do
            use :versionable

            routing do
              get ''
            end

            params do
              attribute :region, String,
                required: false,
                default: 'us-east-1'
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
              attribute :region, String,
                required: true,
                description: 'AWS Region resource resides in'
              attribute :resource_id, Attributor::Collection.of(String),
                required: true,
                description: 'array of resource_id to tag'
              attribute :tags, Attributor::Hash,
                required: true,
                description: 'Key/Value hash of tags'
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
              attribute :region, String,
                required: true,
                description: 'AWS Region resource resides in'
              attribute :resource_id, Attributor::Collection.of(String),
                required: true,
                description: 'array of resource_ids to tag'
              attribute :tags, Attributor::Hash,
                required: true,
                description: 'Key/Value hash of tags'
            end
            response :no_content
            response :ok
          end
        end
      end
    end
  end
end
