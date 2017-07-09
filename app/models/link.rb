require "pg_search"
include PgSearch

class Link < ActiveRecord::Base
  validates :url, :company_id, presence: true
  validates :url, format: {with: URI.regexp}, if: Proc.new{|l| l.url.present?}
  validates :url, uniqueness: true

  has_many :link_hashtags
  has_many :hashtags, through: :link_hashtags  

  belongs_to :company

  pg_search_scope :search, :against => :url
end