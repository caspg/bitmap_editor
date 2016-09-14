require_relative './command_validator'
require_relative './response'
require_relative './bitmap'

class Command
  def create_new_bitmap(splitted_input)
    bitmap = nil
    width = splitted_input[1]
    height = splitted_input[2]
    errors = CommandValidator.new.validate_create_new_bitmap(width, height)

    bitmap = Bitmap.new(width: width, height: height) if errors.empty?
    Response.new(bitmap, errors)
  end

  def clear_bitmap(bitmap)
    bitmap.clear_pixels
    Response.new(bitmap, nil)
  end

  def colour_pixel(bitmap, splitted_input)
    x = splitted_input[1]
    y = splitted_input[2]
    colour = splitted_input[3]
    errors = CommandValidator.new.validate_colour_pixel(bitmap, x, y, colour)

    bitmap.colour_pixel(x, y, colour) if errors.empty?
    Response.new(bitmap, errors)
  end

  def show_bitmap(bitmap)
    bitmap.pixels.transpose.each do |row|
      puts row.join(' ')
    end

    Response.new(bitmap, nil)
  end
end
