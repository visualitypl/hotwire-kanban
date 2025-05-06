require 'rails_helper'

RSpec.describe "/board_bolumns", type: :request do
  let(:board) { create(:board, name: 'Board 1') }

  let(:valid_attributes) { { name: 'Column 1' } }
  let(:invalid_attributes) { { name: nil } }

  describe "GET /new" do
    it "renders a successful response" do
      get new_board_board_column_url(board)

      expect(response).to be_successful
    end
  end

  describe "POST /create" do
    context "with valid parameters" do
      it "creates a new Board Column and redirects to board" do
        expect {
          post board_board_columns_url(board), params: { board_column: valid_attributes }
        }.to change(BoardColumn, :count).by(1)

        expect(response).to redirect_to(board_url(board))
      end
    end

    context "with invalid parameters" do
      it "does not create a new Board Column and returns 422" do
        expect {
          post board_board_columns_url(board), params: { board_column: invalid_attributes }
        }.to change(BoardColumn, :count).by(0)

        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe "GET /edit" do
    it "renders a successful response" do
      board_column = create(:board_column, name: 'Col 1', board: board)
      get edit_board_column_url(board_column)
      expect(response).to be_successful
    end
  end

  describe "PATCH /update" do
    context "with valid parameters" do
      let(:new_attributes) {
        { name: 'Col 2' }
      }

      it "updates the requested board and redirect to the board" do
      board_column = create(:board_column, name: 'Col 1', board: board)
        patch board_column_url(board_column), params: { board_column: new_attributes }
        expect(board_column.reload.name).to eq 'Col 2'
        expect(response).to redirect_to(board_url(board))
      end
    end

    context "with invalid parameters" do
      it "renders a response with 422 status" do
        board_column = create(:board_column, name: 'Col 1', board: board)
        patch board_url(board), params: { board: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe "DELETE /destroy" do
    it "destroys the requested board" do
      board_column = create(:board_column, name: 'Col 1', board: board)
      expect {
        delete board_column_url(board_column)
      }.to change(BoardColumn, :count).by(-1)

      expect(response).to redirect_to(board_url(board))
    end
  end
end
