class BoardColumn < ApplicationRecord
  belongs_to :board
  has_many :cards, dependent: :nullify

  validates :name, presence: true
end
