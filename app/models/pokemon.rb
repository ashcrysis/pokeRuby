class Pokemon < ApplicationRecord
  validates :nome, presence: true
  validates :moves, presence: true
  validates :tipo, presence: true
  validates :imagem, presence: true
end
