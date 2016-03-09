require 'test_helper'

class GameTest < ActiveSupport::TestCase
  test "game without a player fails" do
    assert_raises(Exception) do
      Game.new.save!
    end
  end

  test "two partial frames, one player" do
    the_game = games(:one_player)
    [1111100000,11110,1111100000,11110].each do |t|
      the_game.register_throw(t)
    end
    assert_equal(3, the_game.next_frame_number)
    assert_equal(1, the_game.next_player_number)
    assert_equal(18, the_game.player_score(1))
  end

  test "two frames, spare and partial, one player" do
    the_game = games(:one_player)
    [1111100000,11111,1111100000,11110].each do |t|
      the_game.register_throw(t)
    end
    assert_equal(3, the_game.next_frame_number)
    assert_equal(1, the_game.next_player_number)
    assert_equal(24, the_game.player_score(1))
  end

  test "two frames, strike and partial, one player" do
    the_game = games(:one_player)
    [1111111111,1111100000,11110].each do |t|
      the_game.register_throw(t)
    end
    assert_equal(3, the_game.next_frame_number)
    assert_equal(1, the_game.next_player_number)
    assert_equal(28, the_game.player_score(1))
  end

  test "final game, partials, spares, and strikes, one player" do
    the_game = games(:one_player)
    [1111100000,11110,
     1111111111,
     1111100000,11110,
     1111100000,11110,
     1111100000,11111,
     1111111111,
     1111100000,11110,
     1111100000,11110,
     1111100000,11111,
     1111100000,11110
    ].each do |t|
      the_game.register_throw(t)
    end
    assert_equal(11, the_game.next_frame_number)
    assert_equal(1, the_game.next_player_number)
    assert_equal(127, the_game.player_score(1))
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
     1111111111,
     1111111111
    ].each do |t|
      the_game.register_throw(t)
    end
    assert_equal(11, the_game.next_frame_number)
    assert_equal(1, the_game.next_player_number)
    assert_equal(300, the_game.player_score(1))
    assert(the_game.game_over?)
  end

  test "advance player one to two" do
    the_game = games(:two_player)
    [1111100000,11110].each do |t|
      the_game.register_throw(t)
    end
    assert_equal(1, the_game.next_frame_number)
    assert_equal(2, the_game.next_player_number)
    assert_equal(9, the_game.player_score(1))
    assert_equal(0, the_game.player_score(2))
  end

  test "advance player two to one, advance frame" do
    the_game = games(:two_player)
    [1111100000,11110,1111100000,11110].each do |t|
      the_game.register_throw(t)
    end
    assert_equal(2, the_game.next_frame_number)
    assert_equal(1, the_game.next_player_number)
    assert_equal(9, the_game.player_score(1))
    assert_equal(9, the_game.player_score(2))
  end

  test "two player, incomplete game, total score" do
    the_game = games(:two_player)
    [1111100000,11110,1111100000,11110,1111111111,1111100000,11111].each do |t|
      the_game.register_throw(t)
    end
    assert_equal(3, the_game.next_frame_number)
    assert_equal(1, the_game.next_player_number)
    assert_equal(19, the_game.player_score(1))
    assert_equal(19, the_game.player_score(2))
  end

end
