# frozen_string_literal: true

require './game_logic'

# computer functionality
class Computer
  include GameLogic

  def initialize
    @code = player_create_code
    @guess_array = %w[1 1 2 2] # initial guess
    @possible_codes = (1111..6666).map(&:to_s)
    @num_red_dots = 0
    @num_white_dots = 0
  end

  def player_create_code
    code = []

    puts "\nCreate a code that no one can decipher, even a computer!"
    player_code = gets.chomp.split('')
    if validate_input(player_code) == false
      invalid_input
      player_create_code
    end

    player_code.each { |num| code.push(num) }
  end

  def play
    solved = false
    round = 1

    until solved || round == 13
      dots_array = check_guess(@guess_array, @code) # returns array with dots
      count_dots(dots_array)
      solved = code_solved?(dots_array, @guess_array)
      remove_codes
      make_guess
      round += 1
    end
  end

  def make_guess
    @guess_array = @possible_codes.first.split('')
  end

  def count_dots(dots_array)
    @num_white_dots = 0
    @num_red_dots = 0
    dots_array.each { |dot| dot == "\e[38;2;255;0;0m\u25CF\e[0m" ? @num_red_dots += 1 : @num_white_dots += 1 }
  end

  def remove_codes
    @possible_codes.select! do |code|
      # this makes dots and stores them in an array
      temp_dots_array = check_guess(@guess_array, code.split(''))
      if temp_dots_array.count("\e[38;2;255;0;0m\u25CF\e[0m") == @num_red_dots &&
        temp_dots_array.count("\e[38;2;255;255;255m\u25CF\e[0m") == @num_white_dots
        code
      end
    end
  end
end
