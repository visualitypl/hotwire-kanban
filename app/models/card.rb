class Card < ApplicationRecord
  include ActionView::RecordIdentifier

  belongs_to :board_column

  validates :title, presence: true

  acts_as_list scope: :board_column

  delegate :board, to: :board_column

  after_create_commit :broadcast_card_created
  after_destroy_commit :broadcast_card_destroyed
  after_update_commit :broadcast_card_updated

  private

  def broadcast_card_created
    broadcast_append_to board, target: dom_id(board_column, :column_body), partial: "cards/card", locals: { card: self }
  end

  def broadcast_card_destroyed
    broadcast_remove_to board, target: dom_id(self)
  end

  def broadcast_card_updated
    if previous_changes.key?("board_column_id")
      broadcast_remove_to board, target: dom_id(self)
      broadcast_append_to board, target: dom_id(board_column, :column_body), partial: "cards/card", locals: { card: self }
    else
      broadcast_replace_to board, target: dom_id(self), partial: "cards/card", locals: { card: self }
    end
  end
end
