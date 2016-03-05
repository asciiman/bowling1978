require 'test_helper'

class PlayerTest < ActiveSupport::TestCase
  test "new without player number fails" do
    assert_raises(Exception) {Player.new}
  end

  test "new score is 0" do
    current_player = Player.new(number: 1)
    assert_equal(0, current_player.score )
  end

end
