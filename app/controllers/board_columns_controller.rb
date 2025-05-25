class BoardColumnsController < ApplicationController
  def new
    @board = Board.find(params[:board_id])
    @board_column = @board.board_columns.new
  end

  def edit
    @board_column = BoardColumn.find(params[:id])
  end

  def create
    @board = Board.find(params[:board_id])
    @board_column = @board.board_columns.new(board_column_params)

    respond_to do |format|
      if @board_column.save
        format.html { redirect_to board_url(@board), notice: "BoardColumn was successfully created." }
        format.turbo_stream
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  def update
    @board_column = BoardColumn.find params[:id]

    respond_to do |format|
      if @board_column.update(board_column_params)
        format.html { redirect_to board_url(@board_column.board), notice: "BoardColumn was successfully updated." }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @board_column = BoardColumn.find params[:id]
    board = @board_column.board
    @board_column.destroy!

    respond_to do |format|
      format.html { redirect_to board_url(board), notice: "BoardColumn was successfully destroyed." }
      format.turbo_stream { render turbo_stream: turbo_stream.remove(@board_column) }
    end
  end

  private

  def board_column_params
    params.require(:board_column).permit(:name)
  end
end
