class GamesController < ApplicationController
  include GamesHelper
  def index
    if params["restart"]
    	session["board"] = new_board
    	session["game_over"] = false
    end
    @game_over = session["game_over"]
    session["board"] ||= new_board
    @board = session["board"]
  end

  def move
    board = session["board"]
    flash[:notice] = "Illegal move, try again." unless play_move(params[:col].to_i, board)
    if check_winner(board)
      flash[:notice] = "Player #{check_winner(board) + 1} wins!"
      session["game_over"] = true
    end
    	redirect_to index_path
  end

end
