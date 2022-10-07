# frozen_string_literal: true

require './color_options'
require './color_output'
require './player'
require './text_outputs'
require './computer'

# main class
class Game
  include ColorOptions
  include TextOutputs
  using ColorStrings
  attr_accessor :code

  def initialize
    print_instructions
    until @game_mode == 'break' || @game_mode == 'make'
      print "\nDo you want to break or create the code?(break/make): "
      @game_mode = validate_game_mode(gets.chomp.downcase)
    end
  end

  def play
    if @game_mode == 'break'
      puts "\nCode has been created. Goodluck trying to decipher this one!"
      Player.new.play
    else
      Computer.new.play
    end
  end

  def validate_game_mode(user_input)
    if user_input == 'break' || user_input == 'make'
      user_input
    else
      puts "\nInvalid game mode, please choose either breaker or creator.".fg_color(:red)
    end
  end
end
Game.new.play
