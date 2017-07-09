require_relative './../spec_helper.rb'

RSpec.describe InterpretService do
  before :each do
    @company = create(:company)
    @result = ["Nada encontrado", "Nenhum Faq encontrado", "Não encontramos nada", "Sua busca não teve resultado"]
  end
  describe 'FAQ' do
    describe '#list_faq' do
      it "With zero faqs, return don't find message" do
        response = InterpretService.call('list_faq', {})
        expect(@result).to include(response)
      end

      it "With two faqs, find questions and answer in response" do
        faq1 = create(:faq, company: @company)
        faq2 = create(:faq, company: @company)

        response = InterpretService.call('list_faq', {})

        expect(response).to match(faq1.question)
        expect(response).to match(faq1.answer)

        expect(response).to match(faq2.question)
        expect(response).to match(faq2.answer)
      end
    end

    describe '#search_faq' do
      it "With empty query, return don't find message" do
        response = InterpretService.call('search_faq', {"query": ''})
        expect(@result).to include(response)
      end

      it "With valid query, find question and answer in response" do
        faq = create(:faq, company: @company)

        response = InterpretService.call('search_faq', {"query" => faq.question.split(" ").sample})

        expect(response).to match(faq.question)
        expect(response).to match(faq.answer)
      end
    end

    describe '#search_faq_by_tag' do
      it "With invalid hashtag, return don't find message" do
        response = InterpretService.call('search_faq_by_tag', {"query": ''})
        expect(@result).to include(response)
      end

      it "With valid hashtag, find question and answer in response" do
        faq = create(:faq, company: @company)
        hashtag = create(:hashtag, company: @company)
        create(:faq_hashtag, faq: faq, hashtag: hashtag)

        response = InterpretService.call('search_faq_by_tag', {"query" => hashtag.name})

        expect(response).to match(faq.question)
        expect(response).to match(faq.answer)
      end
    end

    describe '#create_faq' do
      before do
        @question = FFaker::Lorem.sentence
        @answer = FFaker::Lorem.sentence
        @hashtags = "#{FFaker::Lorem.word}, #{FFaker::Lorem.word}"
        @params_invalid = {"question-original" => @question, "answer-original" => @answer}
        @params_valid = {"question-original" => @question, "answer-original" => @answer, "hashtags-original" => @hashtags}
        
      end

      it "Without hashtag params, receive a error" do
        response = InterpretService.call('create_faq', @params_invalid)
        expect(response).to match("Hashtag Obrigatória")
      end

      it "With valid params, receive success message" do
        response = InterpretService.call('create_faq', @params_valid)
        expect(response).to match("Criado com sucesso")
      end

      it "With valid params, find question and anwser in database" do
        response = InterpretService.call('create_faq', @params_valid)
        expect(Faq.last.question).to match(@question)
        expect(Faq.last.answer).to match(@answer)
      end

      it "With valid params, hashtags are created" do
        response = InterpretService.call('create_faq', @params_valid)
        expect(@hashtags.split(/[\s,]+/).first).to match(Hashtag.first.name)
        expect(@hashtags.split(/[\s,]+/).last).to match(Hashtag.last.name)
      end
    end

    describe '#remove_faq' do
      it "With valid ID, remove Faq" do
        faq = create(:faq, company: @company)
        response = InterpretService.call('remove_faq', {"id" => faq.id})
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
        response = InterpretService.call('remove_faq', {"id" => rand(1..9999)})
        expect(["Não encontramos está questão, digite o número correto?", "Não encontramos está questão, qual o número da questão?", "Qual o id/número correto da questão?", "Qual o número da questão?", "Qual o número do faq?", "Questão inválida ou inexistente, verifique o número do faq."]).to include(response)
      end
    end
  end
  describe 'LINK' do
    before do
      @company = create(:company)
      @result = ["Nada encontrado", "Nenhum Link encontrado", "Não encontramos nada", "Sua busca não teve resultado"]
    end
    
    # LIST LINK
    describe '#list_link' do
      it "With zero links, return don't find message" do
        response = InterpretService.call('list_link', {})
        expect(@result).to include(response)
      end      
      it "With two links, find url's in response" do
        link1 = create(:link, company: @company)
        link2 = create(:link, url: 'http://www.uol.com.br', company: @company)

        response = InterpretService.call('list_link', {})
        expect(response).to match(link1.url)
        expect(response).to match(link2.url)
      end
    end
    
    # SEARCH LINK
    describe '#search_link' do
      
      it "With empty query, return don't find message" do
        response = InterpretService.call('search_link', {"query" => ''})
        expect(@result).to include(response)
      end
      
      it "With valid query, find url in response" do
        link = create(:link, company: @company)
        url = URI.parse(link.url)
        response = InterpretService.call('search_link', {"query" => "#{url.host}#{url.path}"})
        expect(response).to match(link.url)
      end
    end  
    
    # LINK SEARCH BY TAGS
    
    describe '#search_link_by_hashtag' do
      it "With invalid hashtag, return don't find message" do
        response = InterpretService.call('search_link_by_tag', {"query": ''})
        expect(@result).to include(response)
      end

      it "With valid hashtag, find url in response" do
        link = create(:link, company: @company)
        hashtag = create(:hashtag, company: @company)
        create(:link_hashtag, link: link, hashtag: hashtag)

        response = InterpretService.call('search_link_by_tag', {"query" => hashtag.name})

        expect(response).to match(link.url)
      end
    end

    #CREATE LINK
    describe '#create_link' do
      before do
        @company = create(:company)
        @url = FFaker::Internet.http_url
        @hashtags = "#{FFaker::Lorem.word}, #{FFaker::Lorem.word}"
        @params_valid = {"url-original" => @url, "hashtags-original" => @hashtags}
        @params_invalid = {"url-original" => @url}
      end

      it "Without hashtag params, receive a error" do
        response = InterpretService.call('create_link', @params_invalid)
        expect(response).to match("Hashtag Obrigatória")
      end

      it "With valid params, receive success message" do
        response = InterpretService.call('create_link', @params_valid)
        expect(response).to be_valid
      end

      it "With valid params, find url in database" do
        response = InterpretService.call('create_link', @params_valid)
        expect(Link.last.url).to match(@url)
      end

      it "With valid params, hashtags are created" do
        response = InterpretService.call('create_link', @params_valid)
        expect(@hashtags.split(/[\s,]+/).first).to match(Hashtag.first.name)
        expect(@hashtags.split(/[\s,]+/).last).to match(Hashtag.last.name)
      end
    end    

    #REMOVE LINK
    describe '#remove_link' do
      it "With valid ID, remove Link" do
        link = create(:link, company: @company)
        response = InterpretService.call('remove_link', {"id" => link.id})
        expect(response).to match("Deletado com sucesso")
      end

      it "With valid ID, remove Link from database" do
        link = create(:link, company: @company)
        remove = LinkModule::RemoveService.new({"id" => link.id})
        expect(Link.all.count).to eq(1)

        response = remove.call()

        expect(Link.all.count).to eq(0)
      end

      it "With invalid ID, receive error message" do
        response = InterpretService.call('remove_link', {"id" => rand(1..9999)})
        expect(['Não encontramos o link, digite o número correto?', 'Não encontramos este link, qual o id correto?', 'Qual o id/número correto do link?', 'Qual o id do link?', 'ID não encontrado ou inexistente, verifique o id correto do link.']).to include(response)
      end
    end      
  end
end