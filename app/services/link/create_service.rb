module LinkModule
  class CreateService
    def initialize(params)
      # TODO: identify origin and set company
      @company = Company.last
      @url = params["url-original"]
      @hashtags = params["hashtags-original"]
    end
    def call
      if @hashtags.blank?
        return "Hashtag Obrigatória"
      end
      link_url = nil   
      begin
        Link.transaction do
          link_url = Link.create(url: @url, company: @company)
          @hashtags.split(/[\s,]+/).each do |hashtag|
            link_url.hashtags << Hashtag.create(name: hashtag)
          end
        end
        link_url 
      rescue
        "Problemas na criação"
      end
    end
  end
end