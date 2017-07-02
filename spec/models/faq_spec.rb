require_relative './../spec_helper.rb'

RSpec.describe Faq, type: :model do
  
  before do
    @company = create(:company)
    @question = FFaker::Lorem.sentence
    @answer = FFaker::Lorem.sentence    
  end
  
  it 'without question Should return an error' do
    faq = build(:faq, question: nil, answer: @answer)
    expect(faq).to be_invalid
  end
  
  it 'without answer Should return an error' do
    faq = build(:faq, question: @question, answer: nil)
    expect(faq).to be_invalid
  end  

  it 'valid Should return assert' do
    faq = create(:faq)
    expect(faq).to be_valid
  end  

  it 'without company Should return an error' do
    faq = build(:faq, question: @question, answer: @answer, company: nil)
    expect(faq).to be_invalid
  end
  
  it 'with company Should return an assert' do
    faq = build(:faq)
    expect(faq).to belong_to(:company)
  end
  
  it 'has_many hashtags Should return an assert' do
    faq = build(:faq)
    expect(faq).to have_many(:hashtags)
  end
    
end