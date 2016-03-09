class Throw < ActiveRecord::Base
  belongs_to :game

  scope :player, -> number {where(player_number: number)}
  scope :frame, -> number {where(frame_number: number)}
  scope :throw, -> number {where(throw_number: number)}

  def score
    pins_down.count("1")
  end
end
