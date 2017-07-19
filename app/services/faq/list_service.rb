module FaqModule
  class ListService
    def initialize(params, action)
      # TODO: identify origin and set company
      @company = Company.last
      @action = action
      @query = params["query"]
    end

    def call
      if @action == "search_faq"
        faqs = Faq.search(@query).where(company: @company)
      elsif @action == "search_faq_by_tag"
        faqs = []
        @company.faqs.each do |faq|
          faq.hashtags.each do |hashtag|
            faqs << faq if hashtag.name == @query
          end
        end
      else
        faqs = @company.faqs
      end

      response = "*Perguntas e Respostas* \n\n"
      faqs.each do |faq|
        response << "*#{faq.id}* - "
        response << "*#{faq.question}*\n"
        response << ">#{faq.answer}\n"
        faq.hashtags.each do |tag|
          response << "_##{tag.name}_ \n"
        end
        response << "\n\n"
      end
      (faqs.count > 0) ? response : ["Nada encontrado", "Nenhum Faq encontrado", "Não encontramos nada", "Sua busca não teve resultado"].sample

    end
  end
end