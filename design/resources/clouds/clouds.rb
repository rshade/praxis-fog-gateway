module V1
  module ApiResources
    class Clouds
      include Praxis::ResourceDefinition
      media_type V1::MediaTypes::Clouds
      version '1.0'
      routing do
        prefix '/api/clouds'
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
