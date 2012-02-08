class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :article

  attr_accessible :body

  validates :user, :presence => true
  validates :article, :presence => true
  validates :body, :presence => true, :length => { :maximum => 50000 }

  default_scope :order => 'comments.created_at asc'
end
