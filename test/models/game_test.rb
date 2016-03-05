require 'test_helper'

class GameTest < ActiveSupport::TestCase
  test "game without a player fails" do
    assert_raises(Exception) {Game.new}
  end

  test "two partial frames, one player" do
    the_game = games(:one_player)
    [1111100000,0000011110,1111100000,0000011110].each do |t|
      the_game.throw(t)
    end
    assert(3, the_game.current_frame)
    assert(1, the_game.current_player.number)
    assert(18, the_game.current_player.score)
  end

  test "two frames, spare and partial, one player" do
    the_game = games(:one_player)
    [1111100000,0000011111,1111100000,0000011110].each do |t|
      the_game.throw(t)
    end
    assert(3, the_game.current_frame)
    assert(1, the_game.current_player.number)
    assert(24, the_game.current_player.score)
  end

  test "two frames, strike and partial, one player" do
    the_game = games(:one_player)
    [1111111111,1111100000,0000011110].each do |t|
      the_game.throw(t)
    end
    assert(3, the_game.current_frame)
    assert(1, the_game.current_player.number)
    assert(28, the_game.current_player.score)
  end

  test "final game, partials, spares, and strikes, one player" do
    the_game = games(:one_player)
    [1111100000,0000011110,
     1111111111,
     1111100000,0000011110,
     1111100000,0000011110,
     1111100000,0000011111,
     1111111111,
     1111100000,0000011110,
     1111100000,0000011110,
     1111100000,0000011111,
     1111100000,0000011110
    ].each do |t|
      the_game.throw(t)
    end
    assert(0, the_game.current_frame)
    assert(1, the_game.current_player.number)
    assert(131, the_game.current_player.score)
    assert(the_game.game_over?)
  end

  test "final game, perfect game, one player" do
    the_game = games(:one_player)
    [1111111111,
     1111111111,
     1111111111,
     1111111111,
     1111111111,
     1111111111,
     1111111111,
     1111111111,
     1111111111,
     1111111111,
    ].each do |t|
      the_game.throw(t)
    end
    assert(0, the_game.current_frame)
    assert(1, the_game.current_player.number)
    assert(300, the_game.current_player.score)
    assert(the_game.game_over?)
  end

  test "advance player one to two" do
    the_game = games(:two_player)
    [1111100000,0000011110].each do |t|
      the_game.throw(t)
    end
    assert(1, the_game.current_frame)
    assert(2, the_game.current_player.number)
    assert(0, the_game.current_player.score)
  end

  test "advance player two to one, advance frame" do
    the_game = games(:two_player)
    [1111100000,0000011110,1111100000,0000011110].each do |t|
      the_game.throw(t)
    end
    assert(2, the_game.current_frame)
    assert(1, the_game.current_player.number)
    assert(9, the_game.current_player.score)
  end

  test "two player, incomplete game, total score" do
    the_game = game(:two_player)
    [1111100000,0000011110,1111100000,0000011110,1111111111,1111100000,0000011111].each do |t|
      the_game.throw(t)
    end
    assert(3, the_game.current_frame)
    assert(1, the_game.current_player.number)
    assert(38, the_game.team_score)
  end

end
