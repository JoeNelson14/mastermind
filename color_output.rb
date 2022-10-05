# frozen_string_literal: true

# moduel to output colored text
module ColorStrings
  RGB_COLOR_MAP = {
    red: '255;0;0',
    green: '0;255;0',
    blue: '0;0;255',
    cyan: '3;252;252',
    pink: '255;0;200',
    orange: '255;140;0',
    white: '255;255;255',
    black: '0;0;0'
  }.freeze

  refine String do
    def fg_color(color_name)
      rgb_val = RGB_COLOR_MAP[color_name]
      "\e[38;2;#{rgb_val}m#{self}\e[0m"
    end

    def bg_color(color_name)
      rgb_val = RGB_COLOR_MAP[color_name]
      "\e[48;2;#{rgb_val}m#{self}\e[0m"
    end
  end
end
