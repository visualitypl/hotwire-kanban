class CardsController < ApplicationController
  def new
    @card = Card.new(board_column_id: params[:board_column_id])
  end

  def create
    @card = Card.new(card_params)

    respond_to do |format|
      if @card.save
        format.html { redirect_to board_url(@card.board), notice: "Card was successfully created." }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  def edit
    @card = Card.find(params[:id])
  end

  def update
    @card = Card.find(params[:id])

    respond_to do |format|
      if @card.update(card_params)
        format.html { redirect_to board_url(@card.board_column.board), notice: "Card was successfully updated." }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @card = Card.find(params[:id])
    board = @card.board_column.board
    @card.destroy!

    respond_to do |format|
      format.html { redirect_to board_url(board), notice: "Card was successfully destroyed." }
    end
  end

  private
    def card_params
      params.require(:card).permit(:title, :description, :board_column_id, :position)
    end
end
