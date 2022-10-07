# frozen_string_literal: true

require './color_options'
require './text_outputs'
require './color_output'
require './game_logic'

# player functionality
class Player
  include TextOutputs
  include ColorOptions
  include GameLogic
  using ColorStrings

  def initialize
    @computer_code = generate_code
    p @computer_code
  end

  def generate_code
    code = []
    4.times { code.push(rand(1..6).to_s) }
    code
  end

  def play
    solved = false
    round = 1

    until solved || round == 13
      puts "\n\tRound #{round}".fg_color(:green)
      current_guess = player_guess

      dots_array = check_guess(current_guess, @computer_code)
      solved = code_solved?(dots_array, current_guess)

      round += 1

      (game_over; print_code(@computer_code); print "\n") if round == 13
    end
  end

  def player_guess
    puts "\nEnter 4 numbers (1-6): "
    player_code = gets.chomp.split('')

    if validate_input(player_code) == false
      invalid_input
      player_guess
    end
    player_code
  end

  def store_player_guess(player_guess_array)
    current_guess = {}

    (1..4).each do |i|
      current_guess[player_guess_array[i - 1].to_sym] = i
    end

    current_guess
  end
end
