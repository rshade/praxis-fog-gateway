  # -p 8888

  require 'bundler/setup'
  require 'praxis'
  file = File.open('logs/praxis-fog-gateway.log', File::WRONLY | File::APPEND)
  application = Praxis::Application.instance
  application.logger = Logger.new(file)
  application.setup

  run application
