require_relative './../spec_helper.rb'

RSpec.describe Hashtag, type: :model do
  
  before do
    @company = create(:company)
  end
  
  it 'without name return a error' do
    hashtag = build(:hashtag, name: nil)
    expect(hashtag).to be_invalid
  end
  
  it 'with company Should return an assert' do
    hashtag = build(:hashtag)
    expect(hashtag).to belong_to(:company)
  end
  
  it 'has_many faqs Should return an assert' do
    hashtag = build(:hashtag)
    expect(hashtag).to have_many(:faqs)
  end    
end
