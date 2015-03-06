module V1
  module MediaTypes
    class Clouds
      class AWS
        class CloudFront < Praxis::MediaType
          include V1::MediaTypes
          identifier 'application/json'
          attributes do
            attribute :string, String
          end
          view :default do
            attribute :string
          end
        end
      end
    end
  end
end
