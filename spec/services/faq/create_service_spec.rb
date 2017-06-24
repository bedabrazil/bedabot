require_relative './../../spec_helper.rb'

describe FaqModule::CreateService do
  before do
    @company = create(:company)
    @question = FFaker::Lorem.sentence
    @answer   = FFaker::Lorem.sentence    
    @hashtags = "#{FFaker::Lorem.word}, #{FFaker::Lorem.word}"

    @params_valid = {"question.original" => @question, 'answer.original' => @answer, 'hashtags.original' => @hashtags}
    @params_invalid = {"question.original" => @question, 'answer.original' => @answer}
  end
  describe '#call' do
    it 'without hashtag params, will receive error' do
      @create_service = FaqModule::CreateService.new(@params_invalid)
      response = @create_service.call()
      expect(response).to match("Hashtag Obrigatória")
    end
    
    it 'with valid params, receive message success' do
      @create_service = FaqModule::CreateService.new(@params_valid)
      response = @create_service.call()
      expect(response).to match('Criado com sucesso')
    end
    it 'with valid params, find question and answer in database' do
      @create_service = FaqModule::CreateService.new(@params_valid)
      response = @create_service.call()
      expect(Faq.last.question).to eq(@question)
      expect(Faq.last.answer).to eq(@answer)
    end
    it 'with valid params, hashtags are created' do
      @create_service = FaqModule::CreateService.new(@params_valid)
      
      response = @create_service.call()
      expect(@hashtags.split(/[\s,]+/).first).to eq(Hashtag.first.name)
      expect(@hashtags.split(/[\s,]+/).last).to eq(Hashtag.last.name)
    end
  end
end