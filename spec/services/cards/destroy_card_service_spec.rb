require 'rails_helper'

RSpec.describe Cards::DestroyCardService, type: :service do
  describe '#call' do
    it 'destroys a card' do
      card = create(:card)
      service = described_class.new(card: card)

      expect { service.call }.to change { Card.count }.by(-1)
    end
  end
end
