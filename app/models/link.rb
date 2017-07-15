require "pg_search"
include PgSearch

class Link < ActiveRecord::Base
  validates_presence_of :url, :company_id
  validates :url, :format => {:with => /\A(http|https):(\/\/)[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(:[0-9]{1,5})?(\/.*)?\z/ix}, :if => Proc.new{|l| l.url.present?}
  validates_uniqueness_of :url

  has_many :link_hashtags
  has_many :hashtags, :through => :link_hashtags  

  belongs_to :company

  pg_search_scope :search, :against => :url

  before_validation :add_protocol, :on => :create
  
  private 
  
  def add_protocol
    unless self.url =~ /\Ahttp:\/\// || self.url =~ /\Ahttps:\/\//
      self.url = "http://#{self.url}"
    end
  end
end