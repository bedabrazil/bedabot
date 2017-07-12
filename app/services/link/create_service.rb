module LinkModule
  class CreateService
    def initialize(params)
      # TODO: identify origin and set company
      @company = Company.last
      @url = params["url-original"]
      @hashtags = params["hashtags-original"]
      puts params
    end
    def call
      if @hashtags.blank?
        return "Hashtag Obrigatória"
      end
      begin
        link = Link.create(url: @url, company: @company)
        @hashtags.split(/[\s,]+/).each do |hashtag|
          link.hashtags << Hashtag.create(name: hashtag, company: @company)
        end
        if link.errors.full_messages.any?
          message = ""
          link.errors.full_messages.each do |error|
            message << "*#{error}\n"
          end
          message
        else
          "Criado com sucesso" 
        end
      rescue => exception
        "Problemas na criação: #{exception}"
      end
    end
  end
end