module FaqModule
  class CreateService
    def initialize(params)
      # TODO: identify origin and set company
      @company = Company.last
      @question = params["question-original"]
      @answer = params["answer-original"]
      @hashtags = params["hashtags-original"]
    end

    def call
      if @hashtags.blank?
        return "Hashtag Obrigatória"
      end
      begin
        Faq.transaction do
          faq = Faq.create(question: @question, answer: @answer, company: @company)
          @hashtags.split(/[\s,]+/).each do |hashtag|
            tag = Hashtag.find_by(name: hashtag, company: @company)
            if tag.blank?
              tag = Hashtag.create(name: hashtag, company: @company)
            end
            faq.hashtags << tag
          end
        end
        "Criado com sucesso"
      rescue
        "Problemas na Criação"
      end
    end
  end
end