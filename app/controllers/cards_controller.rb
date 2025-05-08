class CardsController < ApplicationController
  def new
    @card = Card.new(board_column_id: params[:board_column_id])
  end

  def create
    service = Cards::CreateCardService.new(params: card_params)

    respond_to do |format|
      if service.call
        @card = service.card
        format.html { redirect_to board_url(@card.board), notice: "Card was successfully created." }
      else
        @card = service.card
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  def edit
    @card = Card.find(params[:id])
  end

  def update
    @card = Card.find(params[:id])
    service = Cards::UpdateCardService.new(card: @card, params: card_params)

    respond_to do |format|
      if service.call
        format.html { redirect_to board_url(@card.board_column.board), notice: "Card was successfully updated." }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @card = Card.find(params[:id])
    board = @card.board_column.board
    Cards::DestroyCardService.new(card: @card).call

    respond_to do |format|
      format.html { redirect_to board_url(board), notice: "Card was successfully destroyed." }
      format.turbo_stream
    end
  end

  private
    def card_params
      params.require(:card).permit(:title, :description, :board_column_id, :position)
    end
end
