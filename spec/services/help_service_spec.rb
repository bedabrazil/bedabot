require_relative './../spec_helper.rb'

describe HelpService do
  describe '#call' do
    it "Response have the main commands" do
      response = HelpService.call()
      expect(response).to match('Mostrar estes comandos')
      expect(response).to match('Adiciona uma nova questão ao Faq')
      expect(response).to match('Adiciona um novo Link')
      expect(response).to match('Remove uma questão ou Link baseado no ID/Número')
      expect(response).to match('Pesquisar por tags na lista de perguntas e respostas')
      expect(response).to match('Pesquisar por tags na lista de Links')
    end
  end
end