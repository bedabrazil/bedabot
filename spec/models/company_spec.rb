require_relative './../spec_helper.rb'

RSpec.describe Company, type: :model do
  before do 
    @company = create(:company)
  end

  it 'without name return a error' do
    company = build(:company, name: nil)
    expect(company).to be_invalid
  end
  
  it 'has_many faqs' do
    expect(@company).to have_many(:faqs)
  end

  it 'has_many hashtags' do
    expect(@company).to have_many(:hashtags)    
  end
end