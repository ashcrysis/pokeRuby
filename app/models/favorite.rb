class Favorite < ApplicationRecord
  belongs_to :user
  def self.list
    all
  end
end
