require_relative './../../spec_helper.rb'

describe LinkModule::CreateService do
  before do
    @company = create(:company)
    @link = create(:link, company: @company)
    @hashtags = "#{FFaker::Lorem.word}, #{FFaker::Lorem.word}"
    @params_valid = {"url-original" => @link.url, "hashtags-original" => @hashtags}
    @params_invalid = {"url-original" => @link.url}    
  end
  describe "#call" do
    it "with hashtags params invalid, return an error" do 
      response = LinkModule::CreateService.new(@params_invalid).call
      expect(response).to match("Hashtag Obrigatória")
    end
    it "with hashtags params valid, return an error" do 
      response = LinkModule::CreateService.new(@params_valid).call
      expect(response).to match("Criado com sucesso")
    end    
    it "With valid params, find url in database" do
      response = LinkModule::CreateService.new(@params_valid).call
      expect(Link.last.url).to eq(@link.url)
    end
    it "With valid params, hashtags are created" do
      LinkModule::CreateService.new(@params_valid).call
      expect(@hashtags.split(/[\s,]+/).first).to eq(Hashtag.first.name)
      expect(@hashtags.split(/[\s,]+/).last).to eq(Hashtag.last.name)
    end
  end
end