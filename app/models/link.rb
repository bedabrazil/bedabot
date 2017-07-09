require "pg_search"
include PgSearch

class Link < ActiveRecord::Base
  validates_presence_of :url, :company_id
  validates_uniqueness_of :url
  validates :url, :format => {:with => URI.regexp}, :if => Proc.new{|l| l.url.present?}

  has_many :link_hashtags
  has_many :hashtags, :through => :link_hashtags  

  belongs_to :company

  pg_search_scope :search, :against => :url
end