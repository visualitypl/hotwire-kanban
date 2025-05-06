require "rails_helper"

RSpec.describe Card, type: :model do
  it 'validates presence of title' do
    expect(build(:card)).to be_valid

    expect(build(:card, title: nil)).not_to be_valid
  end

  it 'validates presence of board column' do
    expect(build(:card, board_column: nil)).not_to be_valid
  end

  it 'has board from board column' do
    board_column = build(:board_column)
    card = build(:card, board_column: board_column)

    expect(card.board).to eq board_column.board
  end
end
