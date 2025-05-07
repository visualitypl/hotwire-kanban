require 'rails_helper'

RSpec.describe Cards::CreateCardService, type: :service do
  describe '#call' do
    it 'creates a new card' do
      board = create(:board)
      board_column = create(:board_column, board: board)
      params = { title: 'Card title', description: 'Card description', board_column_id: board_column.id }
      service = described_class.new(params: params)

      expect { service.call }.to change { Card.count }.by(1)
      expect(service.card.title).to eq('Card title')
    end
  end
end
