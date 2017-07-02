require_relative './../spec_helper.rb'

RSpec.describe FaqHashtag, type: :model do
  before do
    @faq = create(:faq)
    @hashtag = create(:hashtag)
  end
  it 'belongs_to faq' do
    faq_hashtag = build(:faq_hashtag)
    expect(faq_hashtag).to belong_to(:faq)
  end
  it 'belongs_to hashtag' do
    faq_hashtag = build(:faq_hashtag)
    expect(faq_hashtag).to belong_to(:hashtag)
  end
  
  it 'without faq' do
    faq_hashtag = build(:faq_hashtag, faq: nil, hashtag: @hashtag)
    expect(faq_hashtag).to be_invalid
  end  
  it 'without hashtag' do
    faq_hashtag = build(:faq_hashtag, faq: @faq, hashtag: nil)
    expect(faq_hashtag).to be_invalid
  end

end