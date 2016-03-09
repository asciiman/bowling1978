class Game < ActiveRecord::Base
  has_many :throws, -> {order(:frame_number, :player_number, :throw_number)}

  validates :player_count, numericality: {greater_than_or_equal_to: 1,
                         less_than_or_equal_to: 8}

  def register_throw(pins)
    throw = Throw.new
    throw.pins_down = pins
    throw.player_number = next_player_number
    throw.frame_number = next_frame_number
    throw.throw_number = next_throw_number
    throw.game = self
    throw.save
  end

  def pin_cleared?(pin)
    throws.last.pins_down.to_i(2) & (1<<pin) > 0 &&
        throws.last.throw_number == 1 && throws.last.score < 10
  end

  def throw_score(player_number, frame_number, throw_number)
    frame = throws.player(player_number).frame(frame_number).
        order(:throw_number)
    the_throw = frame[throw_number-1]

    return '' if throws.empty? || the_throw.nil?
    return '/' if throw_number == 2 &&
        frame.first.score + the_throw.score == 10 && frame.first.score < 10
    return 'X' if throw_number == 1 && the_throw.score == 10
    return 'X' if frame_number == 10 && the_throw.score == 10
    the_throw.score
  end

  def frame_score(player_number, frame_number)
    frame = throws.player(player_number).frame(frame_number)

    return "" if throws.empty? || frame.empty?

    previous_score = frame_number == 1 ? 0 :
        frame_score(player_number, frame_number - 1)

    score = frame.inject(0) {|sum, throw| sum + throw.score}

    next_throw1 = is_spare_or_strike(player_number, frame_number) ?
        subsequent_throw_score(frame.last, 1) : 0
    next_throw2 = is_strike(player_number, frame_number) ?
        subsequent_throw_score(frame.last, 2) : 0

    previous_score + score + next_throw1 + next_throw2
  end

  def player_score(player_number)
    last_frame = throws.player(player_number).order(:throw_number).last
    return 0 if last_frame.nil?
    frame_score(player_number, last_frame.frame_number)
  end

  def next_player_number
    return 1 if throws.empty?
    return throws.last.player_number if !switching_frame?
    return 1 if throws.last.player_number == player_count
    throws.last.player_number + 1
  end

  def next_frame_number
    return 1 if throws.empty?
    return throws.last.frame_number + 1 if switching_frame? &&
        throws.last.player_number == player_count
    throws.last.frame_number
  end

  def game_over?
    return false if throws.empty?
    throws.last.frame_number == 10 &&
        throws.last.player_number == player_count && switching_frame?
  end


  private

  def next_throw_number
    return 1 if throws.empty?
    switching_frame? ? 1 : throws.last.throw_number + 1
  end

  def is_spare_or_strike(player_number, frame_number)
    frame = throws.player(player_number).frame(frame_number)
    frame.inject(0) {|sum, throw| sum + throw.score} >= 10
  end

  def is_strike(player_number, frame_number)
    frame = throws.player(player_number).frame(frame_number).throw(1)
    frame.take.score == 10
  end

  def subsequent_throw_score(throw, offset)
    player_throws = throws.player(throw.player_number).
        order(:frame_number, :throw_number)
    next_throw = player_throws[ player_throws.index(throw) + offset ]
    next_throw.nil? ? 0 : next_throw.score
  end

  def switching_frame?
    return false if throws.empty?
    return true if throws.last.throw_number == 3
    return true if throws.last.throw_number == 2 &&
        throws.last.frame_number < 10
    return true if throws.last.score == 10 && throws.last.frame_number < 10
    throws.last.throw_number == 2 &&
        !is_spare_or_strike(throws.last.player_number, throws.last.frame_number)
  end

end
