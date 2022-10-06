# frozen_string_literal: true

require './color_options'
require './text_outputs'
require './game_logic'
require 'pry'
# computer functionality
class Computer
  include TextOutputs
  include ColorOptions
  include GameLogic

  def initialize
    @code = player_create_code
    @guess_array = ['1', '1', '2', '2'] # initial guess
    @possible_codes = (1111..6666).map { |num| num.to_s }
    @num_red_dots = 0
    @num_white_dots = 0

    p @code
  end

  def player_create_code
    code = []

    puts "\nCreate a code that no one can decipher, even a computer!"
    player_code = gets.chomp.split('')

    player_code.each do |num|
      code.push(num)
    end
    code
  end

  def play
    puts 'we are playing'
    solved = false
    round = 1

    until solved || round == 13
      # binding.pry
      dots_array = guess_in_code?(@guess_array, @code) # returns array with dots
      p dots_array
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
    dots_array.each { |dot| dot == "\e[38;2;255;0;0m\u25CF\e[0m" ? @num_red_dots += 1 : @num_white_dots += 1 }
  end

  def remove_codes
    @possible_codes.select! do |code|
      temp_secret_code = code
      # this makes dots and stores them in an array
      temp_dots_array = guess_in_code?(temp_secret_code.split(''), @guess_array)

      if temp_dots_array.count("\e[38;2;255;0;0m\u25CF\e[0m") == @num_red_dots &&
        temp_dots_array.count("\e[38;2;255;255;255m\u25CF\e[0m") == @num_white_dots
        code
      end
    end
    puts "\t\tThis is new possible codes: #{@possible_codes}"
  end
end
