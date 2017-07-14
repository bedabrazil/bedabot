require "pg_search"
include PgSearch

class Link < ActiveRecord::Base
  validates_presence_of :url, :company_id
  validates_uniqueness_of :url
  validates_format_of :url, :with => /\A(http|https|www):(\/\/)|[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(:[0-9]{1,5})?(\/.*)?\z/, :if => Proc.new{|l| l.url.present?}

  has_many :link_hashtags
  has_many :hashtags, :through => :link_hashtags  

  belongs_to :company

  pg_search_scope :search, :against => :url
  before_save :add_protocol
  
  private 
  
  def add_protocol
    unless self.url[/\Ahttp:\/\//]
      self.url = "http://#{self.url}"
    end
  end
end