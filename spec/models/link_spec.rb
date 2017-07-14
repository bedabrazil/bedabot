require_relative './../spec_helper.rb'

RSpec.describe Link, type: :model do

  it 'with URI invalid return error' do
    link = build(:link, url: 'urlerrada')
    expect(link).to be_invalid
  end
  it 'with URI nil return error' do
    link = build(:link, url: nil)
    expect(link).to be_invalid
  end
  
  it 'with URI uniq return error' do
    link1 = create(:link, url: 'http://www.uol.com.br')
    link3 = build(:link, url: 'http://www.uol.com.br')
    expect(link3).to be_invalid
  end
    
  it 'with URI valid return error' do
    link = create(:link)
    expect(link).to be_valid
  end
  
  it 'belongs_to company' do
    link = build(:link)
    expect(link).to belong_to(:company)
  end
end