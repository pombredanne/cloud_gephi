class Graph < ActiveRecord::Base
  attr_accessible :description, :image, :source
  belongs_to :user
  
  validates :description, length: { maximum: 500 }
  validates :user_id, presence: true
  validates :image, presence: true
  validates :source, presence: true

  default_scope order: 'graphs.created_at DESC'

  # Returns microposts from the users being followed by the given user. 
  def self.from_users_followed_by(user)
    followed_user_ids = "SELECT followed_id FROM relationships
                         WHERE follower_id = :user_id"
    where("user_id IN (#{followed_user_ids}) OR user_id = :user_id",
        user_id: user.id)
  end

end
