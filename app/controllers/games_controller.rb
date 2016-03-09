class GamesController < ApplicationController

  before_action :set_game, only: [:show, :throw]

  def create
    @game = Game.new(game_params[:game])
    @game.save
    redirect_to @game
  end

  def throw
    x = 0
    params[:pin].keys.each {|pin| x = x | (1<<pin.to_i)} if params[:pin]
    @game.register_throw(x.to_s(2))
    redirect_to @game
  end

  private

  def set_game
    @game = Game.find(params[:id])
  end

  def game_params
    params.permit(game: [:player_count])
  end

end
