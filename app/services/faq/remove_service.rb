module FaqModule
  class RemoveService
    def initialize(params)
      # TODO: identify origin and set company
      @company = Company.last
      @params = params
      @id = params["id"]
    end

    def call
      faq = @company.faqs.where(id: @id).last
      if faq.blank?
        return ['Não encontramos está questão, digite o número correto?', 'Não encontramos está questão, qual o número da questão?', 'Qual o id/número correto da questão?', 'Qual o número da questão?', 'Qual o número do faq?', 'Questão inválida ou inexistente, verifique o número do faq.'].sample
      end
      
      Faq.transaction do
        # Deleta as tags associadas que não estejam associadas a outros faqs
        faq.hashtags.each do |h|
          if h.faqs.count <= 1
            h.delete
          end
        end
        faq.delete
        "Deletado com sucesso"
      end
    end
  end
end