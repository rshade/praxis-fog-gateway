module V1
  module ApiResources
    class Clouds
      class AWS
        include Praxis::ResourceDefinition
        media_type V1::MediaTypes::Clouds::AWS

        version '1.0'
        routing do
          prefix '/api/clouds/aws'
        end
        action :index do
          use :versionable
          routing do
            get ''
          end
          response :ok
        end
      end
    end
  end
end
