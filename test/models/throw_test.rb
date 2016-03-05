require 'test_helper'

class ThrowTest < ActiveSupport::TestCase
  test "newly initialized" do
    current_throw = Throw.new()
    assert_equal(0, current_throw.number_down)
  end

  test "some down" do
    current_throw = Throw.new(pins_down: 0110101101)
    assert_equal(6, current_throw.number_down)
  end

  test "all down" do
    current_throw = Throw.new(pins_down: 1111111111)
    assert_equal(10, current_throw.number_down)
  end
end
