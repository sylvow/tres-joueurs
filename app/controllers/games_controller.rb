class GamesController < ApplicationController
  def create
    @meeting = Meeting.find(params[:id])
    @game = Game.new(game_params)
    if @game.save!
      redirect_to meeting_path(@meeting)
    else
      render :new, status: :unprocessable_entity
  end

  private

  def game_params
    params.require(:game).permit(:name, :category, :description)
  end
end
