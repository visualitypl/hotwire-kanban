require "rails_helper"

RSpec.describe BoardColumn, type: :model do
  it 'validates presence of name' do
    expect(build(:board_column)).to be_valid

    expect(build(:board_column, name: nil)).not_to be_valid
  end

  it 'validates presence of board' do
    expect(build(:board_column, board: nil)).not_to be_valid
  end
end
