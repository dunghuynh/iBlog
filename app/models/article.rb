class Article < ActiveRecord::Base
  belongs_to :user
  has_many :comments, :dependent => :destroy
  has_many :ratings, :dependent => :destroy

  attr_accessible :title, :teaser, :body, :version, :changelog

  STATES = {
    :draft => 0,
    :submitted => 1,
    :rejected => 2,
    :accepted => 3,
    :featured => 4
  }
  ACCEPTED_STATES = [STATES[:accepted], STATES[:featured]]

  validates :user_id, :presence => true
  validates :title, :presence => true, :length => {:maximum => 80}
  validates :teaser, :presence => true, :length => {:maximum => 500}
  validates :body, :presence => true
  validates :version, :length => {:maximum => 120}
  validates :changelog, :length => {:maximum => 2000}
  validates :message, :length => {:maximum => 5000}
  validates :state, :presence => true, :numericality => true, :inclusion => {:in => STATES.values}

  def count_ratings
    self.ratings.all.count
  end

  def avg_rating
    avg = self.ratings.average(:stars)
    avg ||= 0
  end

  def approved?
    state.in? ACCEPTED_STATES
  end

  def self.search(search)
    if search
      where('title LIKE ? or teaser LIKE ?', "%#{search}%", "%#{search}%")
    else
      scoped
    end
  end
end
