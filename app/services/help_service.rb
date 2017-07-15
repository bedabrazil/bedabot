
class HelpService
  def self.call
    response  = "*O que eu sei fazer :raised_hands:*\n\n"
    response << "*Mostrar estes comandos*\n"
    response << ">help\n\n>Ajuda\n\n>O que você sabe fazer?\n\n>Listar Comandos\n\n"

    response << "*Adiciona uma nova questão ao Faq*\n"
    response << ">Adicione ao Faq\n\n>Adicionar Faq\n\n>Adicione uma Questão\n\n"

    response << "*Adiciona um novo Link*\n"
    response << ">Adicionar ao link\n\n>Adicionar link\n\n>Adicione um link\n\n"

    response << "*Remove uma questão ou Link baseado no ID/Número*\n"
    response << ">Remover faq ID\n\n>Deletar a questão ID\n\n>Deletar link ID\n\n>Remover Link ID\n\n"

    response << "*Pesquisar por tags na lista de perguntas e respostas*\n\n"
    response << ">O que você conhece sobre X\n\n"
    response << ">Encontre a hashtag X\n\n"
    response << ">Pesquisar sobre X\n\n"
    response << ">Pesquise a hashtag X\n\n"
    response << ">Hashtag X\n\n"
    
    response << "*Pesquisar por tags na lista de Links*\n\n"
    response << ">O que você sabe sobre X\n\n"
    response << ">Buscar a tag X\n\n"
    response << ">Buscar a hashtag X\n\n"
        
  end
end