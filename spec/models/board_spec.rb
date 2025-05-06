require "rails_helper"

RSpec.describe Board, type: :model do
  it 'validates presence of name' do
    expect(build(:board)).to be_valid

    expect(build(:board, name: nil)).not_to be_valid
  end
end
