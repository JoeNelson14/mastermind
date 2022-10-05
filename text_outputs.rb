# frozen_string_literal: true

require './color_options'
require './color_output'

# moduel to output text
module TextOutputs
  include ColorOptions
  using ColorStrings
  # def validate_input(user_input)
  #   if COLOR_OPTIONS.include?(user_input) == false
  #     puts "\nIncorrect color option #{user_input}, please choose another one".fg_color(:red)
  #     false
  #   else
  #     true
  #   end
  # end

  def validate_game_mode(user_input)
    if (user_input == 'break' || user_input == 'make')
      user_input
    else
      puts "\nInvalid game mode, please choose either breaker or creator.".fg_color(:red)
    end
  end

  def print_code(code)
    code.each do |num|
      print "  #{num}  ".bg_color(COLOR_OPTIONS[num]).fg_color(:black)
      print ' '
    end
  end

  def print_instructions
    puts "\nWelcome to MASTERMIND!"
    puts 'In this game you have a code maker and a code breaker, the code breaker will try to guess the code that is'
    puts 'created by the code maker. The code breaker will guess 4 colors starting from position 1-4.'
    puts 'Dots will appear next to the guess giving a hint to which ones are in the right spot and color,'
    puts 'right color wrong spot, or neither right color or spot. You have 12 rounds to try to guess the code.'
    print "\nColor options: "
    print_code(COLOR_OPTIONS.keys)
    print "\n"
    print "\u25CF".fg_color(:red)
    print " = right spot and color\n"
    print "\u25CF".fg_color(:white)
    print " = right color wrong spot\n"
    puts 'no dot = color not in code'
  end

  def game_over
    puts 'GAME OVER YOU DID NOT CRACK THE CODE IN 12 ROUNDS!'.fg_color(:red)
  end
end
