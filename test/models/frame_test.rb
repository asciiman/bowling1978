require 'test_helper'

class FrameTest < ActiveSupport::TestCase
  test "frame number between one and ten" do
    assert_nothing_raised(Frame.new(number: 1))
    assert_nothing_raised(Frame.new(number: 6))
    assert_nothing_raised(Frame.new(number: 10))
  end

  test "frame number outside of one and ten raises error" do
    assert_raises(Exception) {Frame.new}
    assert_raises(Exception) {Frame.new(number: 0)}
    assert_raises(Exception) {Frame.new(number: 11)}
  end

  test "register gutter shows -" do
    assert_equal("-", frames(:gutter).throw_symbol(1))
  end

  test "register partial shows number" do
    assert_equal("5", frames(:partial_partial).throw_symbol(1))
  end

  test "register spare shows /" do
    assert_equal("-", frames(:partial_spare).throw_symbol(2))
  end

  test "register strike shows X" do
    assert_equal("-", frames(:strike).throw_symbol(1))
  end

  test "no throws" do
    current_frame = frames(:no_throws)
    assert_equal(0, current_frame.score)
    assert_not(current_frame.finalized?)
  end

  test "two partials" do
    current_frame = frames(:partial_partial)
    assert_equal(9, current_frame.score)
    assert(current_frame.finalized?)
  end

  test "one throw strike" do
    current_frame = frames(:strike)
    assert_equal(10, current_frame.score)
    assert_not(current_frame.finalized?)
  end

  test "two throws spare" do
    current_frame = frames(:partial_spare)
    assert_equal(10, current_frame.score)
    assert_not(current_frame.finalized?)
  end

  test "strike partial spare" do
    current_frame = frames(:strike_partial_spare)
    assert_equal(20, current_frame.score)
    assert(current_frame.finalized?)
  end

  test "strike strike partial" do
    current_frame = frames(:strike_strike_partial)
    assert_equal(25, current_frame.score)
    assert(current_frame.finalized?)
  end

  test "strike strike strike" do
    current_frame = frames(:strike_strike_strike)
    assert_equal(30, current_frame.score)
    assert(current_frame.finalized?)
  end

  test "spare partial" do
    current_frame = frames(:spare_partial)
    assert_equal(15, current_frame.score)
    assert(current_frame.finalized?)
  end

  test "spare strike" do
    current_frame = frames(:spare_strike)
    assert_equal(20, current_frame.score)
    assert(current_frame.finalized?)
  end

  test "throws after finalized are ignored" do
    current_frame = frames(:partial_partial_partial)
    assert_equal(9, current_frame.score)
    assert(current_frame.finalized?)
  end

end
