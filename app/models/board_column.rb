class BoardColumn < ApplicationRecord
  include ActionView::RecordIdentifier

  belongs_to :board
  has_many :cards, dependent: :nullify

  validates :name, presence: true

  broadcasts_to ->(board_column) { "board_#{board_column.board_id}" },
                target: ->(board_column) { "columns_board_#{board_column.board.id}" },
                inserts_by: :append
end
