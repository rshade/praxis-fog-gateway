  module V1
    module MediaTypes
      class LoadBalancer < Praxis::MediaType

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
