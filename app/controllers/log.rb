  module V1
    class Log
      include Praxis::Controller
      require 'logger'
      implements V1::ApiResources::Log

      HELLO_WORLD = [ 'Hello world!', 'Привет мир!', 'Hola mundo!', '你好世界!', 'こんにちは世界！' ]

      def index(**params)
        f=File.read('./logs/messages.log')
        messages={}
        messages["message"] = []
        f.each_line { |line| messages["message"] << line }
        response.headers['Content-Type'] = 'application/json'
        response.body = messages.to_json
        response
      end

      def show(id:, **other_params)
        hello = HELLO_WORLD[id]
        if hello
          response.body = { id: id, data: hello }
        else
          self.response = Praxis::Responses::NotFound.new
        end
        response.headers['Content-Type'] = 'application/json'
        response
      end
      def create()
        payload = request.payload.contents
        @local_logger = Logger.new('./logs/messages.log')
        @local_logger.level = Logger::WARN
        @local_logger.add(Logger::WARN,payload[:message])
        response.headers['Content-Type'] = 'application/json'
        response.body = "log added: #{payload[:message]}"
        response.status = 201
        response
      end
    end
  end
