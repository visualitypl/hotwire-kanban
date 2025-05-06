class BoardsController < ApplicationController
  before_action :set_board, only: %i[ show edit update destroy ]

  def index
    @boards = Board.all.includes(:board_columns)
  end

  def show
    @board_columns = @board.board_columns.includes(:cards)
  end

  def new
    @board = Board.new
  end

  def edit
  end

  def create
    @board = Board.new(board_params)

    respond_to do |format|
      if @board.save
        format.html { redirect_to boards_url, notice: "Board was successfully created." }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @board.update(board_params)
        format.html { redirect_to boards_url, notice: "Board was successfully updated." }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @board.destroy!

    respond_to do |format|
      format.html { redirect_to boards_url, notice: "Board was successfully destroyed." }
    end
  end

  private
    def set_board
      @board = Board.find(params[:id])
    end

    def board_params
      params.require(:board).permit(:name)
    end
end
