require_relative "assistant/replyer"

module OpenAI
  class Client
    extend OpenAI::HTTP

    def initialize(access_token: nil, organization_id: nil, uri_base: nil, request_timeout: nil)
      OpenAI.configuration.access_token = access_token if access_token
      OpenAI.configuration.organization_id = organization_id if organization_id
      OpenAI.configuration.uri_base = uri_base if uri_base
      OpenAI.configuration.request_timeout = request_timeout if request_timeout
    end

    def chat(parameters: {})
      OpenAI::Client.json_post(path: "/chat/completions", parameters: parameters)
    end

    def suggested_reply(model: nil, incoming_mail: "", reply_summary: "", situation: nil, other_request: nil, assistant: nil)
      response = if !assistant.nil?
                   self.chat(parameters: assistant.parameters)
                 else
                   return if incoming_mail.empty? || reply_summary.empty?

                   self.chat(
                     OpenAI::Assistant::Replyer.new(model: model, incoming_mail: incoming_mail, reply_summary: reply_summary, situation: situation, other_request: other_request)
                   )
                 end
      response
      # TODO: erorrs
    end

    def completions(parameters: {})
      OpenAI::Client.json_post(path: "/completions", parameters: parameters)
    end

    def edits(parameters: {})
      OpenAI::Client.json_post(path: "/edits", parameters: parameters)
    end

    def embeddings(parameters: {})
      OpenAI::Client.json_post(path: "/embeddings", parameters: parameters)
    end

    def files
      @files ||= OpenAI::Files.new
    end

    def finetunes
      @finetunes ||= OpenAI::Finetunes.new
    end

    def images
      @images ||= OpenAI::Images.new
    end

    def models
      @models ||= OpenAI::Models.new
    end

    def moderations(parameters: {})
      OpenAI::Client.json_post(path: "/moderations", parameters: parameters)
    end

    def transcribe(parameters: {})
      OpenAI::Client.multipart_post(path: "/audio/transcriptions", parameters: parameters)
    end

    def translate(parameters: {})
      OpenAI::Client.multipart_post(path: "/audio/translations", parameters: parameters)
    end
  end
end
