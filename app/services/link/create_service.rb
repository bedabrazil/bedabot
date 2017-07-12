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
        if !link.errors.blank?
          "Criado com sucesso" 
        else
          links.errors[0].message
        end
      rescue => exception
        "Problemas na criação"
      end
    end
  end
end