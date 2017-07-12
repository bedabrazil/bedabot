module LinkModule
  class CreateService
    def initialize(params)
      # TODO: identify origin and set company
      @company = Company.last
      @url = params["url"]
      @hashtags = params["hashtags-original"]
      puts params
    end
    def call
      if @hashtags.blank?
        return "Hashtag Obrigatória"
      end
      begin
        Link.transaction do
          link = Link.create(url: @url, company: @company)
          @hashtags.split(/[\s,]+/).each do |hashtag|
            link.hashtags << Hashtag.create(name: hashtag, company: @company)
          end
        end
        "Criado com sucesso" 
      rescue => exception
        "Problemas na criação"
      end
    end
  end
end