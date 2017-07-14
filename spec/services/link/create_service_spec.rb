require_relative './../../spec_helper.rb'

describe LinkModule::CreateService do
  before do
    @company = create(:company)
    @link = build(:link, company: @company)
    @hashtags = "#{FFaker::Lorem.word}, #{FFaker::Lorem.word}"
    @params_valid = {"url-original" => @link.url, "hashtags-original" => @hashtags}
    @params_invalid = {"url-original" => "ttt", "hashtags-original" => @hashtags}    
  end
  describe "#call" do
    it "with url params invalid, return an error url invalid" do 
      response = LinkModule::CreateService.new(@params_invalid).call
      expect(response).to match("*Url is invalid\n")
    end
    it "with url params invalid, return an error url invalid" do
      link = create(:link, company: @company)
      response = LinkModule::CreateService.new({"url-original" => link.url, "hashtags-original" => @hashtags}).call
      expect(response).to match("*Url has already been taken\n")
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