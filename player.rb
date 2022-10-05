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
    p "computer code: #{@computer_code}"
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
      dots_array = guess_in_code?(current_guess, @computer_code)
      solved = code_solved?(dots_array, current_guess)
      round += 1
      (game_over; print_code(@computer_code); print "\n") if round == 13
    end
  end

  def player_guess
    puts "\nEnter 4 numbers (1-6): "
    player_combo = gets.chomp.split('') # splits numbers into array ['1', '2', '3', '4']
    puts "player guess: #{player_combo}"
    while validate_input(player_combo) == false
      puts "\nEnter 4 color guesses: "
      player_combo = gets.chomp.split('')
    end
    player_combo # returns player guess array ['1', '2', '3', '4']
  end

  def validate_input(player_combo)
    if player_combo.any? { |num| !COLOR_OPTIONS.include?(num) } == true
      puts 'Incorrect number combo, please choose another one'.fg_color(:red)
      false
    else
      true
    end
  end

  def store_player_guess(player_guess_array)
    current_guess = {}
    (1..4).each do |i|
      current_guess[player_guess_array[i - 1].to_sym] = i
    end
    current_guess
  end
end
