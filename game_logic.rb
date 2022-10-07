# frozen_string_literal: true

require './color_output'
require './text_outputs'

# module for player and computer files for game logic
module GameLogic
  include TextOutputs
  using ColorStrings

  def check_guess(current_guess, code)
    dots_array = []
    code.each_index do |index|
      if current_guess.include?(code[index]) == true # checks if current number in code was guess or not
        if current_guess.at(index) == code[index] # correct color and spot
          dots_array.push("\u25CF".fg_color(:red)) # adds a red dot to dot array
        else
          dots_array.push("\u25CF".fg_color(:white)) # adds a white dot to array
        end
      end
    end
    dots_array
  end

  def code_solved?(dots_array, current_guess)
    # checks if dots array has all red dots and length of 4
    if dots_array.all? { |dot| dot == "\e[38;2;255;0;0m\u25CF\e[0m" } == true && dots_array.length == 4
      puts "\nCODE SOLVED!".fg_color(:green)
      print_code(current_guess)
      print "\n"
      true
    else
      print_code(current_guess)
      dots_array.each { |dot| print "#{dot}  " }
      print "\n\n"
      false
    end
  end

  def validate_input(player_code)
    false if player_code.length != 4 || player_code.any? { |num| num.to_i > 6 || num.to_i < 1 }
  end
end
