module LinkModule
  class RemoveService
    def initialize(params)
      @company = Company.last
      @params = params
      @id = params["id"]
      puts params
    end
    def call
      link = @company.links.where(id: @id).last
      if link.blank?
        return ['Não encontramos o link, digite o número correto?', 'Não encontramos este link, qual o id correto?', 'Qual o id/número correto do link?', 'Qual o id do link?', 'ID não encontrado ou inexistente, verifique o id correto do link.'].sample        
      end
      
      Link.transaction do
        begin
          link.hashtags.each do |tag|
            if tag.links.count <= 1
              tag.delete
            end
          end
          link.delete
          "Deletado com sucesso"
        rescue
          "Problemas na remoção"
        end
      end
    end
  end
end