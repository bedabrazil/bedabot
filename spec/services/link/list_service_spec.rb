require_relative './../../spec_helper.rb'

describe LinkModule::ListService do
  before do
    @company = create(:company)
    @result = ["Nada encontrado", "Nenhum Link encontrado", "Não encontramos nada", "Sua busca não teve resultado"]
  end
  describe '#list_link', list_link: true do
    it 'with zero links return message error' do
      response = LinkModule::ListService.new('list_link', {}).call()
      expect(@result).to include(response)
    end
    
    it "With two links, find url's in response" do
      link1 = create(:link, company: @company)
      link2 = create(:link, url: 'http://www.uol.com.br', company: @company)

      response = LinkModule::ListService.new('list_link', {}).call
      expect(response).to match(link1.url)
      expect(response).to match(link2.url)
    end    
  end
  describe '#search_link', search_link: true do
    
    it "With empty query, return don't find message" do
      response = LinkModule::ListService.new('search_link', {"query" => ''}).call
      expect(@result).to include(response)
    end
    
    it "With valid query, find url in response" do
      link = create(:link, company: @company)
      response = LinkModule::ListService.new('search_link', {"query" => link.url}).call
      expect(response).to match(link.url)
    end
  end    
end
