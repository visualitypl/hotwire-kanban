require 'rails_helper'

RSpec.describe Cards::UpdateCardService, type: :service do
  describe '#call' do
    it 'updates a card' do
      board = create(:board)
      board_column1 = create(:board_column, board: board)
      board_column2 = create(:board_column, board: board)
      card = create(:card, title: 'Old title', description: 'Old description', board_column: board_column1)
      params = { title: 'New title', description: 'New description', board_column_id: board_column2.id }
      service = described_class.new(card: card, params: params)

      expect { service.call }.to change { card.reload.title }.from('Old title').to('New title')
      expect(card.description).to eq('New description')
      expect(card.board_column).to eq(board_column2)
    end
  end
end
