class GamesController < ApplicationController
  def create
    @meeting = Meeting.find(params[:id])
    @new_game = Game.new(game_params)
    if @new_game.save!
      redirect_to meeting_path(@meeting)
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def game_params
    params.require(:game).permit(:name, :category, :description)
  end
end
