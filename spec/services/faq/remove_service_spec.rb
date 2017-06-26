require_relative './../../spec_helper.rb'

describe FaqModule::RemoveService do
  before do
    @company = create(:company)
  end

  describe '#call' do
    it "With valid ID, remove Faq" do
      faq = create(:faq, company: @company)
      @removeService = FaqModule::RemoveService.new({"id" => faq.id})
      response = @removeService.call()

      expect(response).to match("Deletado com sucesso")
    end

    it "With valid ID, remove Faq from database" do
      faq = create(:faq, company: @company)
      @removeService = FaqModule::RemoveService.new({"id" => faq.id})
      expect(Faq.all.count).to eq(1)

      response = @removeService.call()

      expect(Faq.all.count).to eq(0)
    end

    it "With invalid ID, receive error message" do
      @removeService = FaqModule::RemoveService.new({"id" => rand(1..9999)})
      response = @removeService.call()
      message = ['Digite o número da questão?', 'Qual o número da questão?', 'Qual o id/número da questão?', 'Qual o número da questão?', 'Qual o número do faq?', 'Questão inválida ou inexistente, verifique o número passado.']
      expect(message).to include(response)
    end
  end
end