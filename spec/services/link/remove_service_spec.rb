require_relative './../../spec_helper.rb'

describe LinkModule::RemoveService do
  before do
    @company = create(:company)
  end
  describe "#call" do
    it "with id valid, remove link" do
      link = create(:link, company: @company)
      response = LinkModule::RemoveService.new({"id" => link.id}).call
      expect(response).to match("Deletado com sucesso")
    end
    it "With valid ID, remove Link from database" do
      link = create(:link, company: @company)
      remove = LinkModule::RemoveService.new({"id" => link.id})
      expect(Link.all.count).to eq(1)

      response = remove.call

      expect(Link.all.count).to eq(0)
    end 
    it "With invalid ID, receive error message" do
      remove = LinkModule::RemoveService.new({"id" => rand(1..9999)}).call
      message = ['Não encontramos o link, digite o número correto?', 'Não encontramos este link, qual o id correto?', 'Qual o id/número correto do link?', 'Qual o id do link?', 'ID não encontrado ou inexistente, verifique o id correto do link.']
      expect(message).to include(remove)
    end       
  end
end