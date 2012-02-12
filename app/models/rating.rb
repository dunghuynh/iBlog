class Rating < ActiveRecord::Base

  STARS = 0..5

  belongs_to :user
  belongs_to :article

  attr_accessible :stars

  validates :user, :presence => true
  validates :article, :presence => true
  validates :stars, :presence => true, :numericality => { :only_integer => true }, :inclusion => { :in => STARS }
end
