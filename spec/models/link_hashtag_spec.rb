require_relative './../spec_helper.rb'

RSpec.describe LinkHashtag, type: :model do
  before do
    @link_hashtag = build(:link_hashtag)
  end
  it 'belongs_to link' do
    expect(@link_hashtag).to belong_to(:link)
  end
  it 'belongs_to hashtag' do
    expect(@link_hashtag).to belong_to(:hashtag)
  end

  it 'with link valid' do
    expect(@link_hashtag).to validate_presence_of(:link_id)
  end
  it 'with hashtag valid' do
    expect(@link_hashtag).to validate_presence_of(:hashtag_id)
  end
end