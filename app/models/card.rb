class Card < ApplicationRecord
  belongs_to :board_column

  validates :title, presence: true

  acts_as_list scope: :board_column

  delegate :board, to: :board_column

  after_commit :touch_affected_board_columns

  private

  def touch_affected_board_columns
    if previous_changes[:board_column_id].present?
      board.board_columns.find_by(id: previous_changes[:board_column_id]&.first)&.touch
      board.board_columns.find_by(id: previous_changes[:board_column_id]&.last)&.touch
    else
      board_column.touch
    end
  end
end
