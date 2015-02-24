  # Main entry point - DO NOT MODIFY THIS FILE
  ENV['RACK_ENV'] ||= 'development'

  Bundler.require(:default, ENV['RACK_ENV'])
  require 'yaml'

  # Default application layout.
  # NOTE: This layout need NOT be specified explicitly.
  # It is provided just for illustration.
  Praxis::Application.instance.layout do
    map :initializers, 'config/initializers/**/*'
    map :lib, 'lib/**/*'
    map :design, 'design/' do
      map :api, 'api.rb'
      map :media_types, '**/media_types/**/*'
      map :resources, '**/resources/**/*'
    end
    map :app, 'app/' do
      map :models, 'models/**/*'
      map :controllers, '**/controllers/**/*'
      map :responses, '**/responses/**/*'
    end
  end

  Praxis::Application.instance.config do
    attribute :clouds, Attributor::Hash, required: true
  end

  if File.exists?('./config/cloud_config.yml')
    cloud_values = YAML.load(File.read('./config/cloud_config.yml'))
    Praxis::Application.instance.config = cloud_values
  else
    raise 'config/cloud_config.yml does not exist, please edit the sample, and save as cloud_config.yml'
  end


