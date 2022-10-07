# frozen_string_literal: true

require './color_options'
require './color_output'

# moduel to output text
module TextOutputs
  include ColorOptions
  using ColorStrings

  def print_code(code)
    code.each do |num|
      print "  #{num}  ".bg_color(COLOR_OPTIONS[num]).fg_color(:black)
      print ' '
    end
  end

  def invalid_input
    puts 'Invalid input, please choose 4 numbers only and 1-6.'.fg_color(:red)
  end

  def print_instructions
    puts "\nWelcome to MASTERMIND!"
    puts 'In this game you have a code maker and a code breaker, the code breaker will try to guess the code that is'
    puts 'created by the code maker. The code breaker will guess 4 colors starting from position 1-4.'
    puts 'Dots will appear next to the guess giving a hint to which ones are in the right spot and color,'
    puts 'right color wrong spot, or neither right color or spot. You have 12 rounds to try to guess the code.'
    puts "\nWhen typing a code type numbers with no space (ex. 1234)."
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
