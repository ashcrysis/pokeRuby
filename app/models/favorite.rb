class Favorite < ApplicationRecord
  belongs_to :user
  validates :user_id, presence: true
  def self.list
    all
  end
end
