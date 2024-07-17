class BoardColumn < ApplicationRecord
  include ActionView::RecordIdentifier

  belongs_to :board
  has_many :cards, dependent: :nullify

  validates :name, presence: true

  after_commit :broadcast_column

  def broadcast_column
    broadcast_replace_to(dom_id(board),
                         target: dom_id(self),
                         partial: "board_columns/board_column",
                         locals: { board_column: self })
  end
end
