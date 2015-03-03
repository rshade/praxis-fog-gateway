Class LoadBalancer
  include Praxis::Controller
  implements V1::ApiResources::Clouds

  def index(**params)
    response.headers['Content-Type'] = 'application/json'
    response.body = Praxis::Application.instance.config.providers.to_json
    response
  end
end
