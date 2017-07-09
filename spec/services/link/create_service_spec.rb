require_relative './../../spec_helper.rb'

describe LinkModule::CreateService do
  before do
    @company = create(:company)
    @hashtags = "#{FFaker::Lorem.word}, #{FFaker::Lorem.word}"
    @url = FFaker::Internet.http_url
    @params_valid = {"url-original" => @url, "hashtags-original" => @hashtags}
    @params_invalid = {"url-original" => @url}    
  end
  describe "#call" do
    it "with hashtags params invalid, return an error" do 
      response = LinkModule::CreateService.new(@params_invalid).call
      expect(response).to match("Hashtag Obrigatória")
    end
    it "with hashtags params valid, return an error" do 
      response = LinkModule::CreateService.new(@params_valid).call
      expect(response).to be_valid
    end    
    it "With valid params, find url in database" do
      response = LinkModule::CreateService.new(@params_valid).call
      expect(Link.last.url).to eq(@url)
    end
    it "With valid params, hashtags are created" do
      LinkModule::CreateService.new(@params_valid).call
      expect(@hashtags.split(/[\s,]+/).first).to eq(Hashtag.first.name)
      expect(@hashtags.split(/[\s,]+/).last).to eq(Hashtag.last.name)
    end
  end
end