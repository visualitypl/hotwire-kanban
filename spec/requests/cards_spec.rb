require 'rails_helper'

RSpec.describe "Cards", type: :request do
  let(:board_column) { create(:board_column) }
  let(:valid_attributes) do
    {
      title: 'Column 1',
      description: 'Hello World',
      board_column_id: board_column.id
    }
  end
  let(:invalid_attributes) do
    { title: nil,
      description: 'Hello World',
      board_column_id: board_column.id
    }
  end

  describe "GET /new" do
    it "renders a successful response" do
      get new_card_url(board_column_id: create(:board_column).id)
      expect(response).to be_successful
    end
  end

  describe "POST /create" do
    context "with valid parameters" do
      it "creates a new Card and redirects to board" do
        expect {
          post cards_url, params: { card: valid_attributes }
        }.to change(board_column.cards, :count).by(1)

        expect(response).to redirect_to(board_url(board_column.board))
      end
    end

    context "with invalid parameters" do
      it "does not create a new Board Column and returns 422" do
        expect {
          post cards_url, params: { card: invalid_attributes }
        }.to change(board_column.cards, :count).by(0)

        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe "GET /edit" do
    it "renders a successful response" do
      card = create(:card)
      get edit_card_url(card)
      expect(response).to be_successful
    end
  end

  describe "PATCH /update" do
    context "with valid parameters" do
      let(:new_attributes) { { title: 'Updated card' } }

      it "updates the requested card and redirect to the board" do
        card = create(:card)
        patch card_url(card), params: { card: new_attributes }
        expect(card.reload.title).to eq 'Updated card'
        expect(response).to redirect_to(board_url(card.board_column.board))
      end
    end

    context "with invalid parameters" do
      it "renders a response with 422 status" do
        card = create(:card)
        patch card_url(card), params: { card: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe "DELETE /destroy" do
    it "destroys the requested card" do
      card = create(:card)
      board = card.board_column.board
      expect {
        delete card_url(card)
      }.to change(Card, :count).by(-1)

      expect(response).to redirect_to(board_url(board))
    end
  end
end
