module V1
  module MediaTypes
    class Clouds < Praxis::MediaType
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
