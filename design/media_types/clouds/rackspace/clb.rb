module V1
  module MediaTypes
    class Clouds
      class RackSpace
        class CLB < Praxis::MediaType
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
