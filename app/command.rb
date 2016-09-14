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
    errors = CommandValidator.new.validate_clear_bitmap(bitmap)

    bitmap.clear_pixels if errors.empty?
    Response.new(bitmap, errors)
  end

  def colour_pixel(bitmap, splitted_input)
    x = splitted_input[1]
    y = splitted_input[2]
    colour = splitted_input[3]
    errors = CommandValidator.new.validate_colour_pixel(bitmap, x, y, colour)

    bitmap.colour_pixel(x, y, colour) if errors.empty?
    Response.new(bitmap, errors)
  end

  def draw_vertical_line(bitmap, splitted_input)
    x = splitted_input[1]
    y1 = splitted_input[2]
    y2 = splitted_input[3]
    colour = splitted_input[4]
    errors = CommandValidator.new.validate_draw_vertical_line(bitmap, x, y1, y2, colour)

    bitmap.draw_vertical_line(x, y1, y2, colour) if errors.empty?
    Response.new(bitmap, errors)
  end

  def draw_horizontal_line(bitmap, splitted_input)
    x1 = splitted_input[1]
    x2 = splitted_input[2]
    y = splitted_input[3]
    colour = splitted_input[4]
    errors = CommandValidator.new.validate_draw_horizontal_line(bitmap, x1, x2, y, colour)

    bitmap.draw_horizontal_line(x1, x2, y, colour) if errors.empty?
    Response.new(bitmap, errors)
  end

  def show_bitmap(bitmap)
    bitmap.pixels.transpose.each do |row|
      puts row.join(' ')
    end

    Response.new(bitmap, nil)
  end
end
