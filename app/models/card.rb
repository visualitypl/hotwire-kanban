class Card < ApplicationRecord
  belongs_to :board_column

  validates :title, presence: true

  acts_as_list scope: :board_column

  delegate :board, to: :board_column
end
