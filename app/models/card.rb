class Card < ApplicationRecord
  include ActionView::RecordIdentifier

  belongs_to :board_column

  validates :title, presence: true

  acts_as_list scope: :board_column

  delegate :board, to: :board_column

  after_create_commit :broadcast_card_created
  after_destroy_commit :broadcast_card_destroyed

  private

  def broadcast_card_created
    broadcast_append_to board, target: dom_id(board_column, :column_body), partial: "cards/card", locals: { card: self }
  end

  def broadcast_card_destroyed
    broadcast_remove_to board, target: dom_id(self)
  end
end
